import 'package:dictionary_app/services/user/app_user_domain_object.dart';

abstract interface class UserStorage {
  Future<AppUserDomainObject?> get(String key);
  Future put(String key, AppUserDomainObject user);
  Future delete(String key);
  Future clear();
}
