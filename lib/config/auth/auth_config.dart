import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/auth/login_service.dart';
import 'package:dictionary_app/services/auth/signout/signout_service.dart';
import 'package:dictionary_app/services/auth/simple_email_username_password_login_service.dart';
import 'package:get_it/get_it.dart';

class AuthConfig extends IocConfig {
  @override
  void config() {
    GetIt.I.registerLazySingleton(() => SignoutService());
    GetIt.I.registerLazySingleton<LoginService>(
        () => SimpleEmailUsernamePasswordLoginService());
  }
}
