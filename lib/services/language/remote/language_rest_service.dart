import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth_backed_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/login_service_auth_storage_auth_backed_web_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/language/remote/remote_language.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dio/dio.dart';

class LanguageRESTService
    with
        AuthBackedWebServiceMixin,
        JwtAuthBackedServiceMixin,
        LoginServiceAuthStorageAuthBackedWebServiceMixin,
        CreationService<RemoteLanguage>,
        UpdateService<RemoteLanguage>,
        DeletionService<RemoteLanguage>,
        SimpleDioBackedRESTServiceMixin<RemoteLanguage> {
  final AuthStorage authStorage;
  final LoginService loginService;
  final Dio dio;
  final ServerDetails serverDetails;
  final SerializationUtils serializationUtils;

  LanguageRESTService(
      {required this.authStorage,
      required this.loginService,
      required this.dio,
      required this.serverDetails,
      required this.serializationUtils});
  @override
  Future<AuthStorage> getAuthStorage() async {
    return authStorage;
  }

  @override
  Future<LoginService<Auth, Auth>> getLoginService() async {
    return loginService;
  }

  @override
  Dio getDio() {
    return dio;
  }

  @override
  String getEndpoint() {
    return "${serverDetails.url}/languages";
  }

  @override
  SerializationUtils getSerializationUtils() {
    return serializationUtils;
  }

  Future<ApiPage<RemoteLanguage>> searchByNamePattern(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    try {
      String url = "${getEndpoint()}/nameSearch";
      var response = await dio.get(url,
          queryParameters: {
            "name": namePattern,
            ...pageDetails.toQueryParameters()
          },
          options: Options(headers: await generateAuthHeaders()));

      return deserializeIntoPage(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
