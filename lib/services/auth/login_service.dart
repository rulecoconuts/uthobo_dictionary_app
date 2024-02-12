import 'package:dictionary_app/services/auth/auth.dart';

abstract class LoginService<T extends Auth, R extends Auth> {
  Future<R> login(T auth);
}
