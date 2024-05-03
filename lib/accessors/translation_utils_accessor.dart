import 'package:dictionary_app/services/translation/remote/translation_rest_service.dart';
import 'package:dictionary_app/services/translation/translation_service.dart';
import 'package:get_it/get_it.dart';

mixin TranslationUtilsAccessor {
  Future<TranslationRESTService> translationRESTService() =>
      GetIt.I.getAsync<TranslationRESTService>();

  Future<TranslationService> translationService() =>
      GetIt.I.getAsync<TranslationService>();
}
