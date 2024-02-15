import 'dart:convert';
import 'dart:io';

import 'package:dictionary_app/services/auth/error_handling/invalid_auth_exception.dart';
import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:dictionary_app/services/user/remote/user_rest_service.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SimpleUserRESTService implements UserRESTService {
  final Dio dio;
  final ServerDetails serverDetails;
  final SerializationUtils serializationUtils;
  final AuthStorage authStorage;
  final LoginService loginService;

  SimpleUserRESTService(
      {required this.dio,
      required this.serverDetails,
      required this.serializationUtils,
      required this.authStorage,
      required this.loginService});

  String getEndpoint() {
    return "${serverDetails.url}/users";
  }

  /// Fetch the details of the user associated with the given [auth].
  /// Returns null if the user could not be found.
  /// Throws [InvalidAuthException] if the auth is invalid and cannot be refreshed.
  @override
  Future<RemoteAppUser?> fetchAuthUserData(Auth auth) async {
    var authToUse = await loginService.validateOrRefreshAuth(auth);
    if (authToUse == null) throw InvalidAuthException(auth: auth);

    return await _fetchAuthUserDataInternal(auth);
  }

  /// Shared/main behaviour of fetching user auth data
  Future<RemoteAppUser?> _fetchAuthUserDataInternal(Auth auth) async {
    var authToUse = auth as JwtAuth;

    try {
      String url = "${getEndpoint()}/self";
      var response = await dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${authToUse.token}"
          }));

      if (response.statusCode == 403) return null;

      if (response.statusCode != 200) throw response;

      var user = serializationUtils.deserialize<RemoteAppUser>(response.data);

      return user;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var apiError =
            serializationUtils.deserialize<ApiError>(e.response!.data);
        throw apiError;
      }

      rethrow;
    }
  }

  /// Fetch the details of the user associated with the auth stored in
  /// [authStorage] at [Constants.loginTokenKey].
  /// Returns null if the user could not be found.
  /// Throws [InvalidAuthException] if the auth is invalid and cannot be refreshed.
  @override
  Future<RemoteAppUser?> fetchLoggedInUserData() async {
    var authToUse = (await loginService.validateOrRefreshAuthInStorage(
        authStorage, Constants.loginTokenKey)) as JwtAuth?;
    if (authToUse == null) {
      throw InvalidAuthException(
          auth: await authStorage.get(Constants.loginTokenKey));
    }

    return await _fetchAuthUserDataInternal(authToUse);
  }
}
