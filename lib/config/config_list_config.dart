import 'package:dictionary_app/config/ioc_config.dart';

abstract class ConfigListConfig extends IocConfig {
  List<IocConfig> getConfigs();

  @override
  void config() {
    getConfigs().forEach((element) {
      element.config();
    });
  }
}
