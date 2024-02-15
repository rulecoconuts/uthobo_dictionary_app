import 'dart:convert';
import 'dart:io';

import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/email_username_password_auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Login service that sends a login request containing credentials in the form
/// of email, username and password.
/// It expects [JwtAuth] containing a token as a response.
class SimpleEmailUsernamePasswordLoginService
    extends LoginService<EmailUsernamePasswordAuth, JwtAuth> {
  final Dio dio;
  final ServerDetails serverDetails;
  final SerializationUtils serializationUtils;

  SimpleEmailUsernamePasswordLoginService(
      {required this.dio,
      required this.serverDetails,
      required this.serializationUtils});

  @override
  Future<JwtAuth> login(EmailUsernamePasswordAuth auth) async {
    try {
      var formData = FormData.fromMap(auth.toJson());
      var response =
          await dio.post("${serverDetails.url}/login", data: formData);

      if (response.statusCode != 200) throw response;

      var bearerToken = response.headers.value("AUTHORIZATION");
      var refreshToken = response.headers.value("Refresh-Token");
      return JwtAuth(
          token: bearerToken!.replaceFirst("Bearer ", ""),
          refreshToken: refreshToken);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 403 && e.response?.data is Map) {
          var apiError =
              serializationUtils.deserialize<ApiError>(e.response!.data);
          throw apiError;
        }
      }
      rethrow;
    }
  }

  Future<JwtAuth> refresh(JwtAuth jwtAuth) async {
    try {
      var response = await dio.post("${serverDetails.url}/users/refresh",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${jwtAuth.token}",
            if (jwtAuth.refreshToken != null)
              "Refresh-Token": jwtAuth.refreshToken
          }));

      if (response.statusCode != 200) throw response;

      var bearerToken = response.headers.value("AUTHORIZATION");
      var refreshToken = response.headers.value("Refresh-Token");
      return JwtAuth(
          token: bearerToken!.replaceFirst("Bearer ", ""),
          refreshToken: refreshToken);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 403 && e.response?.data is Map) {
          var apiError =
              serializationUtils.deserialize<ApiError>(e.response!.data);
          throw apiError;
        }
      }
      rethrow;
    }
  }

  @override
  Future<JwtAuth?> validateOrRefreshAuth(JwtAuth auth) async {
    String? error = await validateAuth(auth);

    if (error == null) return auth;

    if (error == AuthValidationErrors.invalidFormat.name) return null;

    // Attempt to refresh token
    return await refresh(auth);
  }

  @override
  Future<JwtAuth?> validateOrRefreshAuthInStorage(
      AuthStorage storage, String key) async {
    Auth? storedAuth = await storage.get(key);

    if (storedAuth == null) return null;

    if (storedAuth is! JwtAuth) return null;

    JwtAuth? retrievedAuth = await validateOrRefreshAuth(storedAuth);

    if (retrievedAuth != null) {
      await storage.put(key, retrievedAuth);
    }

    return retrievedAuth;
  }

  /// Checks whether [auth] is valid.
  /// Valid in this case means [auth] is of the correct format for a JWT and
  /// is not close to expiry
  @override
  Future<String?> validateAuth(JwtAuth auth) async {
    try {
      DateTime expiryDate = JwtDecoder.getExpirationDate(auth.token);
      DateTime now = DateTime.now();
      if (now.compareTo(expiryDate) == 0) {
        // The current time is the expiry date on the dot
        return AuthValidationErrors.expired.name;
      }

      Duration durationTillExpiry = expiryDate.difference(now);

      if (durationTillExpiry.isNegative) {
        // Current time has passed expiry date
        return AuthValidationErrors.expired.name;
      }

      Duration minimumAllowedDurationTillExpiry = Duration(hours: 12);
      int comparison =
          durationTillExpiry.compareTo(minimumAllowedDurationTillExpiry);

      if (comparison == -1) return AuthValidationErrors.almostExpired.name;

      return null;
    } on FormatException catch (e, stackTrace) {
      return AuthValidationErrors.invalidFormat.name;
    }
  }
}
