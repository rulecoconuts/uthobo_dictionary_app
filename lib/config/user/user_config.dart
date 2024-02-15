import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/user/remote/simple_user_rest_service.dart';
import 'package:dictionary_app/services/user/remote/user_rest_service.dart';
import 'package:get_it/get_it.dart';

class UserConfig extends IocConfig
    with ServerUtilsAccessor, SerializationUtilsAccessor, AuthUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingletonAsync<UserRESTService>(() async =>
        SimpleUserRESTService(
            dio: dio(),
            serverDetails: serverDetails(),
            serializationUtils: serializationUtils(),
            authStorage: await authStorage(),
            loginService: loginService()));
  }
}
