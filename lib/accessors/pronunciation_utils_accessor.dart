import 'package:dictionary_app/services/pronunciation/pronunciation_deletion_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_scheduler.dart';
import 'package:dictionary_app/services/pronunciation/remote/pronunciation_rest_service.dart';
import 'package:get_it/get_it.dart';

mixin PronunciationUtilsAccessor {
  PronunciationDeletionService pronunciationDeletionService() =>
      GetIt.I<PronunciationDeletionService>();
  Future<PronunciationUploadScheduler> pronunciationUploadScheduler() =>
      GetIt.I.getAsync<PronunciationUploadScheduler>();

  Future<PronunciationRESTService> pronunciationRESTService() =>
      GetIt.I.getAsync<PronunciationRESTService>();

  Future<PronunciationService> pronunciationService() =>
      GetIt.I.getAsync<PronunciationService>();
}
