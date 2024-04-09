import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';

class IsolateUploadUpdate {
  PronunciationPresignResult pronunciationPresignResult;
  int bytesUploaded;
  int totalBytes;

  bool isComplete = false;
  bool isFailed = false;
  Object? error;
  StackTrace? stackTrace;

  IsolateUploadUpdate(
      {required this.pronunciationPresignResult,
      required this.bytesUploaded,
      required this.totalBytes,
      this.isComplete = false,
      this.isFailed = false,
      this.error,
      this.stackTrace});
}
