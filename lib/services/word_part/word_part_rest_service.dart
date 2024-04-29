import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth_backed_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/login_service_auth_storage_auth_backed_web_service_mixin.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/remote/remote_pronunciation.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/word_part/remote_word_part.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';

class WordPartRESTService
    with
        AuthBackedWebServiceMixin,
        JwtAuthBackedServiceMixin,
        LoginServiceAuthStorageAuthBackedWebServiceMixin,
        CreationService<RemoteWordPart>,
        UpdateService<RemoteWordPart>,
        DeletionService<RemoteWordPart>,
        SimpleDioBackedRESTServiceMixin<RemoteWordPart> {
  final AuthStorage authStorage;
  final Dio dio;
  final ServerDetails serverDetails;

  final LoginService loginService;
  final SerializationUtils serializationUtils;

  WordPartRESTService(
      {required this.authStorage,
      required this.dio,
      required this.serverDetails,
      required this.loginService,
      required this.serializationUtils});

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
    return "${serverDetails.url}/word_parts";
  }

  @override
  Future<LoginService<Auth, Auth>> getLoginService() async {
    return loginService;
  }

  @override
  SerializationUtils getSerializationUtils() {
    return serializationUtils;
  }

  Future<List<RemotePronunciation>> getPronunciations(
      RemoteWordPart wordPart) async {
    try {
      String url = "${getEndpoint()}/${wordPart.id}/pronunciations";
      var dio = getDio();

      var request = await dio.get(url,
          options: Options(headers: await generateAuthHeaders()));

      return serializationUtils
          .deserializeList<RemotePronunciation>(request.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }
}
