import 'package:dictionary_app/accessors/flavor_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/flavor/app_flavor.dart';
import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ServerConfig extends IocConfig with FlavorUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingleton(() {
      var dioConfig = Dio();
      dioConfig.options.headers[Headers.acceptHeader] = "application/json";
      return dioConfig;
    });
    GetIt.I.registerLazySingleton(() => ServerDetails(
            url: switch (appFlavor()) {
          AppFlavor.LOCAL => "http://10.0.2.2:8080/api",
          AppFlavor.DEV => "https://dev.langresus.com/api",
          _ => ""
        }));
  }
}
