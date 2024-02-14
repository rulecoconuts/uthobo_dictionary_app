import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';

abstract class LoginService<T extends Auth, R extends Auth> {
  Future<R> login(T auth);

  /// If [auth] is valid, return null; else return description of auth invalid state
  Future<String?> validateAuth(R auth);

  /// If [auth] is valid, return [auth];
  /// if [auth] is invalid, attempt to refresh auth.
  /// If auth can be refreshed, return new auth; else return null
  Future<R?> validateOrRefreshAuth(R auth);

  /// Try to validate or refresh auth stored at [key] in [storage].
  /// If auth is valid, return auth;
  /// if auth is invalid, attempt to refresh auth.
  /// If auth can be refreshed, store new auth at [key] in [storage] and return it; else return null
  Future<R?> validateOrRefreshAuthInStorage(AuthStorage storage, String key);
}
