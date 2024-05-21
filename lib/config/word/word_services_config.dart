import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/accessors/word_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/word/simple_word_REST_service.dart';
import 'package:dictionary_app/services/word/simple_word_service.dart';
import 'package:dictionary_app/services/word/word_service.dart';
import 'package:dictionary_app/services/word_part/simple_word_part_service.dart';
import 'package:dictionary_app/services/word_part/word_part_rest_service.dart';
import 'package:dictionary_app/services/word_part/word_part_service.dart';
import 'package:get_it/get_it.dart';

class WordServicesConfig extends IocConfig
    with
        ServerUtilsAccessor,
        SerializationUtilsAccessor,
        AuthUtilsAccessor,
        WordUtlsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingletonAsync(() async => SimpleWordRESTService(
        authStorage: (await authStorage()),
        loginService: loginService(),
        serverDetails: serverDetails(),
        serializationUtils: serializationUtils(),
        dio: dio()));

    GetIt.I.registerLazySingletonAsync<WordService>(() async =>
        SimpleWordService(
            simpleWordRESTService: await simpleWordRESTService()));

    GetIt.I.registerLazySingletonAsync(() async => WordPartRESTService(
        authStorage: await authStorage(),
        dio: dio(),
        serverDetails: serverDetails(),
        loginService: loginService(),
        serializationUtils: serializationUtils()));

    GetIt.I.registerLazySingletonAsync<WordPartService>(() async =>
        SimpleWordPartService(
            wordPartRESTService: await wordPartRESTService()));
  }
}
