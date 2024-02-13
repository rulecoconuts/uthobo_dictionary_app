import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/services/auth/email_username_password_auth.dart';
import 'package:dictionary_app/services/auth/jwt_auth.dart';
import 'package:dictionary_app/services/auth/login_service.dart';
import 'package:dio/dio.dart';

/// Login service that sends a login request containing credentials in the form
/// of email, username and password.
/// It expects [JwtAuth] containing a token as a response.
class SimpleEmailUsernamePasswordLoginService
    extends LoginService<EmailUsernamePasswordAuth, JwtAuth>
    with ServerUtilsAccessor {
  @override
  Future<JwtAuth> login(EmailUsernamePasswordAuth auth) async {
    try {
      var formData = FormData.fromMap(auth.toJson());
      var response =
          await dio().post("${serverDetails().url}/login", data: formData);

      if (response.statusCode != 200) throw response;

      var bearerToken = response.headers.value("AUTHORIZATION");
      return JwtAuth(token: bearerToken!.replaceFirst("Bearer ", ""));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 403) {
          // TODO: deserialize and throw response body (error details)
        }
      }
      rethrow;
    }
  }
}
