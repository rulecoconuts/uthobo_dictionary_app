import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/language_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/language/language_service.dart';
import 'package:dictionary_app/services/language/remote/language_rest_service.dart';
import 'package:dictionary_app/services/language/simple_rest_backed_domain_language_service.dart';
import 'package:get_it/get_it.dart';

class LanguageConfig extends IocConfig
    with
        ServerUtilsAccessor,
        AuthUtilsAccessor,
        SerializationUtilsAccessor,
        LanguageUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingletonAsync(() async => LanguageRESTService(
        authStorage: await authStorage(),
        loginService: loginService(),
        dio: dio(),
        serverDetails: serverDetails(),
        serializationUtils: serializationUtils()));

    GetIt.I.registerLazySingletonAsync<LanguageService>(() async =>
        SimpleRESTBackedDomainLanguageService(
            languageRESTService: await languageRESTService()));
  }
}
