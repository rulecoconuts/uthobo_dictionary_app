import 'dart:io';

import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth_backed_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/login_service_auth_storage_auth_backed_web_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/translation/remote/remote_translation.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';

class TranslationRESTService
    with
        CreationService<RemoteTranslation>,
        UpdateService<RemoteTranslation>,
        DeletionService<RemoteTranslation>,
        AuthBackedWebServiceMixin,
        JwtAuthBackedServiceMixin,
        LoginServiceAuthStorageAuthBackedWebServiceMixin,
        SimpleDioBackedRESTServiceMixin<RemoteTranslation> {
  final AuthStorage authStorage;
  final Dio dio;
  final ServerDetails serverDetails;
  final SerializationUtils serializationUtils;
  final LoginService loginService;

  const TranslationRESTService(
      {required this.authStorage,
      required this.dio,
      required this.serializationUtils,
      required this.serverDetails,
      required this.loginService});

  @override
  Future<AuthStorage> getAuthStorage() async {
    return authStorage;
  }

  @override
  Dio getDio() {
    return dio;
  }

  @override
  String getEndpoint() {
    return "${serverDetails.url}/translations";
  }

  @override
  Future<LoginService<Auth, Auth>> getLoginService() async {
    return loginService;
  }

  @override
  SerializationUtils getSerializationUtils() {
    return serializationUtils;
  }

  /// Validate a translation context at the backend
  Future<bool> isContextValid(TranslationContextDomainObject context) async {
    try {
      String url = "${getEndpoint()}/context/validate";
      var dio = getDio();
      var response = dio.post(url,
          data: getSerializationUtils().serialize(context),
          options: Options(headers: await generateAuthHeaders()));
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse &&
          e.response?.statusCode == HttpStatus.notFound) {
        return false;
      }

      handleDioException(e);
      rethrow;
    }
  }
}
