import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/services/pronunciation/isolate_upload_update.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_scheduler.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/pronunciation/upload_stage.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
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

    if (uploadsToPersist.isEmpty) return;
    // List<String> localFilePaths =
    //     uploadsToPersist.map((e) => e.pronunciation.audioUrl).toList();

    try {
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
    } catch (e, stackTrace) {
      uploadsToPersist.forEach((task) => _recordFailure(task));
      rethrow;
    }
  }

  /// Notify listeners that an upload has succeeded
  void _notifySuccess(PronunciationPresignResult presignResult) {
    _eventStreamController.add(PronunciationUploadStatus(
        pronunciationPresignResult: presignResult,
        progress: 1,
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

    if (newActiveTasks.isEmpty) return;

    // Start all new active upload tasks in an isolate
    _startUploadIsolateWork(newActiveTasks);
  }

  Future _startUploadIsolateWork(List<PronunciationPresignResult> tasks) async {
    await workerManager.executeWithPort((port) async {
      await _uploadAll(tasks, port);
    },
        onMessage: _handleIsolateUplodUpdate,
        priority: WorkPriority.immediately);
  }

  /// Handle upload update messages from secondary isolates in the main isolate
  void _handleIsolateUplodUpdate(IsolateUploadUpdate update) {
    if (update.isComplete) {
      _moveToAwaitingPersistenceQueue(update.pronunciationPresignResult);
    } else if (update.isFailed) {
      _recordFailure(update.pronunciationPresignResult);
    } else {
      _updateUploadProgress(update.pronunciationPresignResult,
          update.bytesUploaded, update.totalBytes);
    }
  }

  static Future _uploadAll(
      List<PronunciationPresignResult> tasks, SendPort sendPort) async {
    Dio dio = Dio();
    var uploadTaskFutures = tasks.map((e) => _upload(e, sendPort, dio));

    await Future.wait(uploadTaskFutures);
  }

  /// Upload pronunciation using presigned URL
  static Future _upload(
      PronunciationPresignResult result, SendPort sendPort, Dio dio) async {
    File file = File(result.pronunciation.audioUrl);
    int bytesUploaded = 0;
    int length = 0;

    try {
      length = await file.length();

      var mimeType = lookupMimeType(file.path);

      var response = await dio.put(result.presignedUrl,
          data: file.openRead(),
          options: Options(headers: {
            Headers.contentLengthHeader: length,
            Headers.contentTypeHeader: mimeType ?? "application/octet-stream",
            "x-amz-acl": "public-read"
          }), onSendProgress: (count, total) {
        // Send upload progress to main isolate
        bytesUploaded = count;
        sendPort.send(IsolateUploadUpdate(
            pronunciationPresignResult: result,
            bytesUploaded: count,
            totalBytes: total));
      });

      // Send success to main isolate
      sendPort.send(IsolateUploadUpdate(
          pronunciationPresignResult: result,
          bytesUploaded: length,
          totalBytes: length,
          isComplete: true));
    } catch (e, stackTrace) {
      // Send failure to main isolate
      sendPort.send(IsolateUploadUpdate(
          pronunciationPresignResult: result,
          bytesUploaded: bytesUploaded,
          totalBytes: length,
          isFailed: true,
          error: e,
          stackTrace: stackTrace));
    }
  }

  /// Record pronunciation upload failure
  Future _recordFailure(PronunciationPresignResult result) async {
    await activeMutex.protectWrite(() async => active.remove(result));

    // Notify listeners
    _eventStreamController.add(PronunciationUploadStatus(
        pronunciationPresignResult: result, stage: UploadStage.failed));

    // Upload failed; Delete local file.
    // Note: This can be changed to make retries possible.
    await _deleteLocalFile(result);
  }

  /// Move to successful queue
  Future _moveToAwaitingPersistenceQueue(
      PronunciationPresignResult result) async {
    await awaitingPersistenceMutex.protectWrite(() async {
      await activeMutex.protectWrite(() async {
        active.remove(result);
        awaitingPersistence.add(result);
      });
    });

    // Delete local file since upload has been completed
    await _deleteLocalFile(result);
  }

  /// Delete the local pronunciation file
  Future _deleteLocalFile(PronunciationPresignResult result) async {
    File file = File(result.pronunciation.audioUrl);

    if (!(await file.exists())) return;

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
