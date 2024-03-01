import 'package:dictionary_app/config/auth/auth_config.dart';
import 'package:dictionary_app/config/config_list_config.dart';
import 'package:dictionary_app/config/flavor/app_flavor_config.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/config/language/language_config.dart';
import 'package:dictionary_app/config/part/part_of_speech_services_config.dart';
import 'package:dictionary_app/config/pronunciation/pronunciation_services_config.dart';
import 'package:dictionary_app/config/routing/main_routing_config.dart';
import 'package:dictionary_app/config/serialization/serialization_config.dart';
import 'package:dictionary_app/config/server/server_config.dart';
import 'package:dictionary_app/config/storage/storage_config.dart';
import 'package:dictionary_app/config/user/user_config.dart';
import 'package:dictionary_app/config/word/word_services_config.dart';
import 'package:dictionary_app/services/flavor/app_flavor.dart';

class MainConfig extends ConfigListConfig {
  AppFlavor appFlavor;

  MainConfig({required this.appFlavor});

  @override
  List<IocConfig> getConfigs() {
    return [
      AppFlavorConfig(appFlavor: appFlavor),
      StorageConfig(),
      SerializationConfig(),
      ServerConfig(),
      AuthConfig(),
      UserConfig(),
      LanguageConfig(),
      WordServicesConfig(),
      PartOfSpeechServicesConfig(),
      PronunciationServicesConfig(),
      MainRoutingConfig()
    ];
  }
}
