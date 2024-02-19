import 'package:dictionary_app/services/language/remote/language_rest_service.dart';
import 'package:get_it/get_it.dart';

mixin LanguageUtilsAccessor {
  Future<LanguageRESTService> languageRESTService() =>
      GetIt.I.getAsync<LanguageRESTService>();
}
