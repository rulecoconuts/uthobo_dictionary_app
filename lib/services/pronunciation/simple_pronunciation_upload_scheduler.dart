import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_scheduler.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/pronunciation/upload_stage.dart';
import 'package:dio/dio.dart';
import 'package:mutex/mutex.dart';
import 'package:worker_manager/worker_manager.dart';

class SimplePronunciationUploadScheduler
    implements PronunciationUploadScheduler {
  final Queue<PronunciationPresignResult> pending = Queue();
  final Queue<PronunciationPresignResult> active = Queue();
  final Queue<PronunciationPresignResult> awaitingPersistence = Queue();

  final pendingMutex = ReadWriteMutex();
  final activeMutex = ReadWriteMutex();
  final awaitingPersistenceMutex = ReadWriteMutex();

  final int maxActiveSize;

  final StreamController<PronunciationUploadStatus> _eventStreamController =
      StreamController.broadcast();

  Timer? activeVacancyCheckTimer;
  Duration activeVacancyCheckInterval;

  Timer? awaitingPersistenceCheckTimer;
  Duration awaitingPersistenceCheckInterval;

  final Dio dio;
  final PronunciationService pronunciationService;

  SimplePronunciationUploadScheduler(
      {required this.dio,
      required this.pronunciationService,
      this.maxActiveSize = 4,
      this.activeVacancyCheckInterval = const Duration(milliseconds: 30),
      this.awaitingPersistenceCheckInterval =
          const Duration(milliseconds: 30)});

  void start() {
    _startActiveVacancyCheckLoop();
    _startAwaitingPersistenceCheckLoop();
  }

  void stop() {
    _stopActiveVacancyCheckLoop();
    _stopAwaitingPersistenceCheckLoop();
  }

  /// Check upload status of a pronunciation
  @override
  Future<PronunciationUploadStatus> checkStatus(
      PronunciationPresignResult pronunciationPresignResult) async {
    // Check in active
    PronunciationPresignResult? found;

    found = await activeMutex.protectRead(() async => active
        .where((element) => element == pronunciationPresignResult)
        .firstOrNull);

    if (found != null) {
      return PronunciationUploadStatus(
          pronunciationPresignResult: found, stage: UploadStage.active);
    }

    found = await pendingMutex.protectRead(() async => pending
        .where((element) => element == pronunciationPresignResult)
        .firstOrNull);

    if (found != null) {
      return PronunciationUploadStatus(
          pronunciationPresignResult: pronunciationPresignResult,
          stage: UploadStage.pending);
    }

    found = await awaitingPersistenceMutex.protectRead(() async =>
        awaitingPersistence
            .where((element) => element == pronunciationPresignResult)
            .firstOrNull);

    if (found != null) {
      return PronunciationUploadStatus(
          pronunciationPresignResult: pronunciationPresignResult,
          stage: UploadStage.awaitingPersistence);
    }

    return PronunciationUploadStatus(
        pronunciationPresignResult: pronunciationPresignResult,
        stage: UploadStage.doesNotExist);
  }

  void _stopActiveVacancyCheckLoop() {
    activeVacancyCheckTimer?.cancel();
  }

  /// Start periodically checking for vacancies in active queue
  void _startActiveVacancyCheckLoop() {
    activeVacancyCheckTimer?.cancel();

    activeVacancyCheckTimer =
        Timer.periodic(activeVacancyCheckInterval, (timer) {
      _checkAndFillActiveVacancy();
    });
  }

  void _startAwaitingPersistenceCheckLoop() {
    awaitingPersistenceCheckTimer?.cancel();
    awaitingPersistenceCheckTimer =
        Timer.periodic(awaitingPersistenceCheckInterval, (timer) {
      _persistUploads();
    });
  }

  void _stopAwaitingPersistenceCheckLoop() {
    awaitingPersistenceCheckTimer?.cancel();
  }

  /// Persist succesful pronunciation uploads in the backend
  Future _persistUploads() async {
    List<PronunciationPresignResult> uploadsToPersist =
        await awaitingPersistenceMutex.protectWrite(() async {
      var records = awaitingPersistence.toList();
      awaitingPersistence.clear();
      return records;
    });

    // Persist pronunciations
    List<PronunciationDomainObject> newPronunciations =
        await pronunciationService.createAll(uploadsToPersist
            .map((e) => e.pronunciation..audioUrl = e.destinationUrl)
            .toList());

    /// Notify listeners of upload successes
    newPronunciations
        .map((pronunciation) => uploadsToPersist
            .where(
                (element) => element.destinationUrl == pronunciation.audioUrl)
            .firstOrNull
          ?..pronunciation = pronunciation)
        .nonNulls
        .forEach(_notifySuccess);
  }

  /// Notify listeners that an upload has succeeded
  void _notifySuccess(PronunciationPresignResult presignResult) {
    _eventStreamController.add(PronunciationUploadStatus(
        pronunciationPresignResult: presignResult,
        stage: UploadStage.successful));
  }

  /// Check for space in active queue, and fill it
  Future _checkAndFillActiveVacancy() async {
    int vacancySize = await activeMutex
        .protectRead(() async => maxActiveSize - active.length);

    await _moveToActive(vacancySize);
  }

  /// Move [size] from pending to active queue
  Future _moveToActive(int size) async {
    List<PronunciationPresignResult> newActiveTasks =
        await pendingMutex.protectWrite(() async {
      return await activeMutex.protectWrite(() async {
        return _move(from: pending, to: active, amountToMove: size);
      });
    });

    // Upload all
    workerManager.execute(() {
      newActiveTasks.forEach(_upload);
    }, priority: WorkPriority.immediately);
  }

  /// Upload pronunciation using presigned URL
  Future _upload(PronunciationPresignResult result) async {
    File file = File(result.pronunciation.audioUrl);

    try {
      int length = await file.length();

      var response = await dio.put(
        result.presignedUrl,
        data: file.openRead(),
        options: Options(headers: {Headers.contentLengthHeader: length}),
        onSendProgress: (count, total) =>
            _updateUploadProgress(result, count, total),
      );

      await _moveToAwaitingPersistenceQueue(result, response, file);
    } catch (e, stackTrace) {
      await _recordFailure(result, file);
    }
  }

  /// Record pronunciation upload failure
  Future _recordFailure(PronunciationPresignResult result, File file) async {
    await activeMutex.protectWrite(() async => active.remove(result));
    await file.delete();

    // Notify listeners
    _eventStreamController.add(PronunciationUploadStatus(
        pronunciationPresignResult: result, stage: UploadStage.failed));
  }

  /// Move to successful queue
  Future _moveToAwaitingPersistenceQueue(
      PronunciationPresignResult result, Response response, File file) async {
    await awaitingPersistenceMutex.protectWrite(() async {
      await activeMutex.protectWrite(() async {
        active.remove(result);
        awaitingPersistence.add(result);
      });
    });

    await file.delete();
  }

  /// Notify listeners of a change in upload progress of a pronunciation
  void _updateUploadProgress(
      PronunciationPresignResult result, int bytesSent, int total) {
    _eventStreamController.add(PronunciationUploadStatus(
        pronunciationPresignResult: result,
        stage: UploadStage.active,
        progress: bytesSent / total));
  }

  /// Move [amountToMove] elements from the front of [from] to the end of [to]
  List<PronunciationPresignResult> _move(
      {required Queue<PronunciationPresignResult> from,
      required Queue<PronunciationPresignResult> to,
      required int amountToMove}) {
    List<PronunciationPresignResult> newlyMoved = [];
    for (int i = 0; i < amountToMove && from.isNotEmpty; i++) {
      var element = from.removeFirst();
      to.add(element);
      newlyMoved.add(element);
    }

    return newlyMoved;
  }

  /// Schedule pronunciation upload
  @override
  Future schedule(PronunciationPresignResult pronunciationPresignResult) async {
    await pendingMutex
        .protectWrite(() async => pending.add(pronunciationPresignResult));
  }

  /// Schedule a list of pronunciation uploads
  @override
  Future scheduleAll(
      List<PronunciationPresignResult> pronunciationPresignResults) async {
    await pendingMutex
        .protectWrite(() async => pending.addAll(pronunciationPresignResults));
  }

  @override
  Stream<PronunciationUploadStatus> listen(
      PronunciationPresignResult presignResult) async* {
    await for (var status in _eventStreamController.stream) {
      if (status.pronunciationPresignResult == presignResult) yield status;
    }
  }

  /// Listen for upload status events related to a word part
  @override
  Stream<PronunciationUploadStatus> listenForWordPart(int wordPartId) async* {
    await for (var status in _eventStreamController.stream) {
      if (status.pronunciationPresignResult.pronunciation.wordPartId ==
          wordPartId) yield status;
    }
  }
}
