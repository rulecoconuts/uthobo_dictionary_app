import 'dart:convert';

import 'package:dictionary_app/services/auth/registration/registration_service.dart';
import 'package:dictionary_app/services/auth/registration/simple_user_registration_request.dart';
import 'package:dictionary_app/services/auth/registration/user_registration_request.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dio/dio.dart';

class SimpleRegistrationService
    implements RegistrationService<SimpleUserRegistrationRequest> {
  final Dio dio;
  final ServerDetails serverDetails;
  final SerializationUtils serializationUtils;

  SimpleRegistrationService(
      {required this.dio,
      required this.serverDetails,
      required this.serializationUtils});

  @override
  Future<bool> register(
      SimpleUserRegistrationRequest registrationRequest) async {
    try {
      var data = serializationUtils.serialize(registrationRequest.user);
      var response =
          await dio.post("${serverDetails.url}/users/register", data: data);

      if (response.statusCode != 200) throw response;

      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var apiError = serializationUtils
            .deserialize<ApiError>(json.decode(e.response!.data as String));
        throw apiError;
      }
      rethrow;
    }
  }
}
