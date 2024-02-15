import 'package:dictionary_app/services/auth/login/auth.dart';

class InvalidAuthException implements Exception {
  final Auth? auth;
  final String? message;

  InvalidAuthException({this.auth, this.message});
}
