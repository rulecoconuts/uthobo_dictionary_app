import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';

abstract class PronunciationUploadScheduler {
  Future schedule(PronunciationPresignResult pronunciationPresignResult);
  Future scheduleAll(
      List<PronunciationPresignResult> pronunciationPresignResults);
  Future<PronunciationUploadStatus> checkStatus(
      PronunciationPresignResult pronunciationPresignResult);

  Future<List<PronunciationUploadStatus>> checkStatusForWordPart(
      int wordPartId);

  void start();

  void stop();

  Stream<PronunciationUploadStatus> listen(
      PronunciationPresignResult presignResult);

  Stream<PronunciationUploadStatus> listenForWordPart(int wordPartId);
}
