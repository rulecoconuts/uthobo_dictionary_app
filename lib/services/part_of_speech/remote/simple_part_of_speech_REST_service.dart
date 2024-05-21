import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth_backed_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/login_service_auth_storage_auth_backed_web_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_REST_service.dart';
import 'package:dictionary_app/services/part_of_speech/remote/remote_part_of_speech.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';

class SimplePartOfSpeechRESTService
    with
        AuthBackedWebServiceMixin,
        JwtAuthBackedServiceMixin,
        LoginServiceAuthStorageAuthBackedWebServiceMixin,
        CreationService<RemotePartOfSpeech>,
        UpdateService<RemotePartOfSpeech>,
        DeletionService<RemotePartOfSpeech>,
        SimpleDioBackedRESTServiceMixin<RemotePartOfSpeech>
    implements PartOfSpeechRESTService {
  final AuthStorage authStorage;
  final Dio dio;
  final LoginService loginService;
  final SerializationUtils serializationUtils;
  final ServerDetails serverDetails;

  SimplePartOfSpeechRESTService(
      {required this.authStorage,
      required this.dio,
      required this.loginService,
      required this.serializationUtils,
      required this.serverDetails});

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
    return "${serverDetails.url}/parts_of_speech";
  }

  @override
  Future<LoginService<Auth, Auth>> getLoginService() async {
    return loginService;
  }

  @override
  SerializationUtils getSerializationUtils() {
    return serializationUtils;
  }

  @override
  Future<ApiPage<RemotePartOfSpeech>> searchByNamePattern(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    try {
      String url = "${getEndpoint()}/nameSearch";
      var response = await getDio().get(url,
          queryParameters: {
            "name": namePattern,
            ...pageDetails.toQueryParameters()
          },
          options: Options(headers: await generateAuthHeaders()));

      return deserializeIntoPage(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }
}
