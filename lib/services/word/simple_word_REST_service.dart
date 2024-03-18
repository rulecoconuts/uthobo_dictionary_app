import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth_backed_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/login_service_auth_storage_auth_backed_web_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_service.dart';
import 'package:dio/dio.dart';

class SimpleWordRESTService
    with
        AuthBackedWebServiceMixin,
        JwtAuthBackedServiceMixin,
        LoginServiceAuthStorageAuthBackedWebServiceMixin {
  AuthStorage authStorage;

  LoginService loginService;

  ServerDetails serverDetails;

  Dio dio;

  SerializationUtils serializationUtils;

  SimpleWordRESTService(
      {required this.authStorage,
      required this.loginService,
      required this.serverDetails,
      required this.serializationUtils,
      required this.dio});

  Future<ApiPage<FullWordPart>> searchForFullWordPartByName(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    try {
      String url = "${serverDetails.url}/words/nameSearch/full";
      var response = await dio.get(url,
          queryParameters: {
            "name": namePattern,
          },
          options: Options(
            headers: await generateAuthHeaders(),
          ));

      return serializationUtils
          .deserializeIntoPage<FullWordPart>(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  Future<ApiPage<FullWordPart>> searchForFullWordPartByNameInLanguage(
      String namePattern, LanguageDomainObject language,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    try {
      String url =
          "${serverDetails.url}/words/language/${language.id}/nameSearch/full";
      var response = await dio.get(url,
          queryParameters: {
            "name": namePattern,
          },
          options: Options(
            headers: await generateAuthHeaders(),
          ));

      return serializationUtils
          .deserializeIntoPage<FullWordPart>(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  void handleDioException(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      if (e.response?.data is! Map) throw e;
      throw serializationUtils.deserialize<ApiError>(e.response!.data);
    }

    throw e;
  }

  @override
  Future<AuthStorage> getAuthStorage() async {
    return authStorage;
  }

  @override
  Future<LoginService<Auth, Auth>> getLoginService() async {
    return loginService;
  }
}
