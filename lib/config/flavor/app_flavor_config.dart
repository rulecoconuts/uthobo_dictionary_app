import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/flavor/app_flavor.dart';
import 'package:get_it/get_it.dart';

class AppFlavorConfig extends IocConfig {
  AppFlavor appFlavor;

  AppFlavorConfig({required this.appFlavor});
  @override
  void config() {
    GetIt.I.registerLazySingleton(() => appFlavor);
  }
}
