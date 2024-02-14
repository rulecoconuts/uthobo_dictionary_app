import 'package:dictionary_app/services/auth/login/auth.dart';

abstract interface class AuthStorage {
  Future put(String key, Auth auth);
  Future<Auth?> get(String key);
  Future delete(String key);
  Future clear();
}
