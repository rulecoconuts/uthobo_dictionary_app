import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth.dart';
import 'package:dictionary_app/services/auth/login/simple_email_username_password_login_service.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("SimpleEmailUsernamePasswordLoginService test", () {
    var dio = Dio();
    SerializationUtils serializationUtils = SerializationUtils();
    ServerDetails serverDetails = ServerDetails(url: "");
    SimpleEmailUsernamePasswordLoginService loginService =
        SimpleEmailUsernamePasswordLoginService(
            dio: dio,
            serverDetails: serverDetails,
            serializationUtils: serializationUtils);

    test("validateAuth method identifies invalid formatted token", () async {
      var auth = JwtAuth(token: "rnornr0894ji4h4n40nu0fnf0nf0 f 0 0f");
      String? error = await loginService.validateAuth(auth);
      expect(error, equals(AuthValidationErrors.invalidFormat.name));
    });

    test("validateAuth method identifies token that is way past expiry",
        () async {
      var auth = JwtAuth(
          token:
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE3MDc4ODEyMzEsImV4cCI6MTcwNzg4MTQxMywiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.MZgLxV3R49mLRjAf9hnJ23A_45E1gCorwAw9ZnnedCc");
      String? error = await loginService.validateAuth(auth);
      expect(error, equals(AuthValidationErrors.expired.name));
    });

    test("validateAuth method identifies expired on the dot token", () async {
      String token = JWT(
        {'id': "34"},
      ).sign(SecretKey("test"), expiresIn: Duration(seconds: 0));
      var auth = JwtAuth(token: token);
      String? error = await loginService.validateAuth(auth);
      expect(error, equals(AuthValidationErrors.expired.name));
    });

    test("validateAuth method identifies almost expired token", () async {
      String token = JWT(
        {'id': "34"},
      ).sign(SecretKey("test"), expiresIn: Duration(hours: 11));
      var auth = JwtAuth(token: token);
      String? error = await loginService.validateAuth(auth);
      expect(error, equals(AuthValidationErrors.almostExpired.name));
    });

    test("validateAuth method identifies valid token", () async {
      String token = JWT(
        {'id': "34"},
      ).sign(SecretKey("test"), expiresIn: Duration(days: 5));
      var auth = JwtAuth(token: token);
      String? error = await loginService.validateAuth(auth);
      expect(error, isNull);
    });
  });
}
