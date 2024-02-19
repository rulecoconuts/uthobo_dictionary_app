import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';

abstract interface class UserService<C> {
  Future<AppUserDomainObject?> fetchLoggedInUserData();
  Future<AppUserDomainObject?> fetchAuthUserData(Auth auth);
  Future<bool> register(C user);
}
