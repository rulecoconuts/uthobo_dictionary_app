import 'package:dictionary_app/accessors/flavor_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/auth/login_service.dart';
import 'package:dictionary_app/services/auth/signout/signout_service.dart';
import 'package:dictionary_app/services/auth/simple_email_username_password_login_service.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/auth/storage/simple_auth_storage.dart';
import 'package:dictionary_app/services/storage/hive_backed_app_object_storage.dart';
import 'package:get_it/get_it.dart';

class AuthConfig extends IocConfig
    with SerializationUtilsAccessor, FlavorUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingleton(() => SignoutService());
    GetIt.I.registerLazySingleton<LoginService>(
        () => SimpleEmailUsernamePasswordLoginService());

    GetIt.I.registerLazySingletonAsync<AuthStorage>(() async =>
        SimpleAuthStorage(
            storage: await HiveBackedAppObjectStorage.secure(
                "${appFlavor().name}_auth_store"),
            serializationUtils: serializationUtils()));
  }
}
