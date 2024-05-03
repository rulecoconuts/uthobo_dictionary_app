import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/accessors/translation_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/translation/remote/translation_rest_service.dart';
import 'package:dictionary_app/services/translation/simple_translation_service.dart';
import 'package:dictionary_app/services/translation/translation_service.dart';
import 'package:get_it/get_it.dart';

class TranslationServicesConfig extends IocConfig
    with
        AuthUtilsAccessor,
        ServerUtilsAccessor,
        SerializationUtilsAccessor,
        TranslationUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingletonAsync(() async => TranslationRESTService(
        authStorage: await authStorage(),
        dio: dio(),
        serializationUtils: serializationUtils(),
        serverDetails: serverDetails(),
        loginService: loginService()));

    GetIt.I.registerLazySingletonAsync<TranslationService>(() async =>
        SimpleTranslationService(
            translationRESTService: await translationRESTService()));
  }
}
