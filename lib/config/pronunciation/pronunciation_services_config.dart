import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_deletion_service.dart';
import 'package:dictionary_app/services/pronunciation/simple_pronunciation_deletion_service.dart';
import 'package:get_it/get_it.dart';

class PronunciationServicesConfig extends IocConfig {
  @override
  void config() {
    GetIt.I.registerLazySingleton<PronunciationDeletionService>(
        () => SimplePronunciationDeletionService());
  }
}
