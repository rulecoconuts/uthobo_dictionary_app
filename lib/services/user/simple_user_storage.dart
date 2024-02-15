import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/user_storage.dart';

class SimpleUserStorage implements UserStorage {
  @override
  Future clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<AppUserDomainObject?> get(String key) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future put(String key, AppUserDomainObject user) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
