import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth_backed_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/login_service_auth_storage_auth_backed_web_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/remote/remote_pronunciation.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dio/dio.dart';

class PronunciationRESTService
    with
        AuthBackedWebServiceMixin,
        JwtAuthBackedServiceMixin,
        LoginServiceAuthStorageAuthBackedWebServiceMixin,
        CreationService<RemotePronunciation>,
        UpdateService<RemotePronunciation>,
        DeletionService<RemotePronunciation>,
        SimpleDioBackedRESTServiceMixin<RemotePronunciation> {
  final AuthStorage authStorage;
  final Dio dio;
  final ServerDetails serverDetails;
  final SerializationUtils serializationUtils;
  final LoginService loginService;

  PronunciationRESTService(
      {required this.authStorage,
      required this.dio,
      required this.serverDetails,
      required this.serializationUtils,
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
    return "${serverDetails.url}/pronunciations";
  }

  @override
  Future<LoginService<Auth, Auth>> getLoginService() async {
    return loginService;
  }

  @override
  SerializationUtils getSerializationUtils() {
    return serializationUtils;
  }

  /// Presign upload url to authenticate pronunciation upload
  Future<PronunciationPresignResult> presign(
      PronunciationCreationRequest creationRequest) async {
    try {
      String url = "${getEndpoint()}/presign-upload-url";
      var dio = getDio();
      var response = await dio.post(url,
          data: serializationUtils.serialize(creationRequest),
          options: Options(headers: await generateAuthHeaders()));

      return serializationUtils
          .deserialize<PronunciationPresignResult>(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }
}
