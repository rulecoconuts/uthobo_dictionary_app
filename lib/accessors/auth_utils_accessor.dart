import 'package:dictionary_app/services/auth/login_service.dart';
import 'package:dictionary_app/services/auth/signout/signout_service.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:get_it/get_it.dart';

mixin AuthUtilsAccessor {
  SignoutService signoutService() => GetIt.I<SignoutService>();
  LoginService loginService() => GetIt.I<LoginService>();
  Future<AuthStorage> authStorage() => GetIt.I.getAsync<AuthStorage>();
}
