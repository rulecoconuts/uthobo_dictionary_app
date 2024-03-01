import 'package:dictionary_app/services/pronunciation/pronunciation_deletion_service.dart';
import 'package:get_it/get_it.dart';

mixin PronunciationUtilsAccessor {
  PronunciationDeletionService pronunciationDeletionService() =>
      GetIt.I<PronunciationDeletionService>();
}
