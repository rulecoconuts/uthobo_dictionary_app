import 'package:dictionary_app/services/auth/email_username_password_auth.dart';
import 'package:dictionary_app/services/auth/jwt_auth.dart';

abstract class Auth {
  String get type;

  static Auth fromJson(Map<String, dynamic> json) {
    String type = json["type"];

    if (type == EmailUsernamePasswordAuth.getType()) {
      return EmailUsernamePasswordAuth.fromJson(json);
    } else if (type == JwtAuth.getType()) {
      return JwtAuth.fromJson(json);
    }

    throw UnsupportedError("The supplied Auth type \"$type\" is not supported");
  }
}
