import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/part_of_speech_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_REST_service.dart';
import 'package:dictionary_app/services/part_of_speech/remote/simple_part_of_speech_REST_service.dart';
import 'package:dictionary_app/services/part_of_speech/simple_part_of_speech_service.dart';
import 'package:get_it/get_it.dart';

class PartOfSpeechServicesConfig extends IocConfig
    with
        AuthUtilsAccessor,
        SerializationUtilsAccessor,
        ServerUtilsAccessor,
        PartOfSpeechUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingletonAsync<PartOfSpeechRESTService>(() async =>
        SimplePartOfSpeechRESTService(
            authStorage: await authStorage(),
            dio: dio(),
            loginService: loginService(),
            serializationUtils: serializationUtils(),
            serverDetails: serverDetails()));

    GetIt.I.registerLazySingletonAsync(() async => SimplePartOfSpeechService(
        partOfSpeechRESTService: (await partOfSpeechRESTService())
            as SimplePartOfSpeechRESTService));
  }
}
