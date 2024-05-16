import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/registration/registration_service.dart';
import 'package:dictionary_app/services/auth/signout/signout_service.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:get_it/get_it.dart';

mixin AuthUtilsAccessor {
  Future<SignoutService> signoutService() => GetIt.I.getAsync<SignoutService>();
  LoginService loginService() => GetIt.I<LoginService>();
  RegistrationService registrationService() => GetIt.I<RegistrationService>();
  Future<AuthStorage> authStorage() => GetIt.I.getAsync<AuthStorage>();
}
