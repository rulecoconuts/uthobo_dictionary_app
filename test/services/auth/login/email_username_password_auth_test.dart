import 'dart:convert';

import 'package:dictionary_app/services/auth/login/email_username_password_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test EmailUsernamePasswordAuth freezed generated code", () {
    test("Generated Freezed Constructor assigns values to fields properly", () {
      var auth = EmailUsernamePasswordAuth(
          password: "Solomon", email: "follower@gmail.com", username: "candy");

      expect(auth.username, equals("candy"));
      expect(auth.password, equals("Solomon"));
      expect(auth.email, equals("follower@gmail.com"));
    });

    test("fromJson works properly", () {
      String jsonString =
          '{"username": "corn", "password": "test", "email":"tatoo@hotmail.com"}';
      var auth = EmailUsernamePasswordAuth.fromJson(json.decode(jsonString));
      expect(auth.username, equals("corn"));
      expect(auth.password, equals("test"));
      expect(auth.email, equals("tatoo@hotmail.com"));
    });

    test("toJson works properly", () {
      var auth = EmailUsernamePasswordAuth(
          password: "Golly", email: "standing@gmail.com", username: "Pale");

      Map<String, dynamic> map = auth.toJson();
      expect(map["email"], equals("standing@gmail.com"));
      expect(map["password"], equals("Golly"));
      expect(map["username"], equals("Pale"));
      expect(map["type"], equals(EmailUsernamePasswordAuth.getType()));
    });
  });
}
