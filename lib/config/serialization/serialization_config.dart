import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/language/remote/remote_language.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:get_it/get_it.dart';

class SerializationConfig extends IocConfig {
  @override
  void config() {
    GetIt.I.registerLazySingleton(() => SerializationUtils()
      ..addDeserializer<Auth>(Auth.fromJson)
      ..addDeserializer<ApiError>(ApiError.fromJson)
      ..addDeserializer<RemoteAppUser>(RemoteAppUser.fromJson)
      ..addDeserializer<AppUserDomainObject>(AppUserDomainObject.fromJson)
      ..addDeserializer(RemoteLanguage.fromJson));
  }
}
