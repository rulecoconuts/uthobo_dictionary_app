import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/auth/auth.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:get_it/get_it.dart';

class SerializationConfig extends IocConfig {
  @override
  void config() {
    GetIt.I.registerLazySingleton(
        () => SerializationUtils()..addDeserializer<Auth>(Auth.fromJson));
  }
}
