import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/server_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_deletion_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_scheduler.dart';
import 'package:dictionary_app/services/pronunciation/remote/pronunciation_rest_service.dart';
import 'package:dictionary_app/services/pronunciation/simple_pronunciation_deletion_service.dart';
import 'package:dictionary_app/services/pronunciation/simple_pronunciation_service.dart';
import 'package:dictionary_app/services/pronunciation/simple_pronunciation_upload_scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:worker_manager/worker_manager.dart';

class PronunciationServicesConfig extends IocConfig
    with
        AuthUtilsAccessor,
        ServerUtilsAccessor,
        SerializationUtilsAccessor,
        PronunciationUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingleton<PronunciationDeletionService>(
        () => SimplePronunciationDeletionService());

    GetIt.I.registerLazySingletonAsync<PronunciationRESTService>(() async =>
        PronunciationRESTService(
            authStorage: await authStorage(),
            dio: dio(),
            serverDetails: serverDetails(),
            serializationUtils: serializationUtils(),
            loginService: loginService()));

    GetIt.I.registerLazySingletonAsync<PronunciationService>(() async =>
        SimplePronunciationService(
            pronunciationRESTService: await pronunciationRESTService()));

    GetIt.I.registerLazySingletonAsync<PronunciationUploadScheduler>(() async {
      await workerManager.init();
      return SimplePronunciationUploadScheduler(
          dio: dio(), pronunciationService: await pronunciationService())
        ..start();
    });
  }
}
