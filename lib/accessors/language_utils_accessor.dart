import 'package:dictionary_app/services/language/language_service.dart';
import 'package:dictionary_app/services/language/remote/language_rest_service.dart';
import 'package:get_it/get_it.dart';

mixin LanguageUtilsAccessor {
  Future<LanguageRESTService> languageRESTService() =>
      GetIt.I.getAsync<LanguageRESTService>();

  Future<LanguageService> languageDomainService() =>
      GetIt.I.getAsync<LanguageService>();
}
