import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/upload_stage.dart';

class PronunciationUploadStatus {
  PronunciationPresignResult pronunciationPresignResult;
  UploadStage stage;
  double progress;

  PronunciationUploadStatus(
      {required this.pronunciationPresignResult,
      required this.stage,
      this.progress = 0});
}
