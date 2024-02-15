import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/config/routing/auth_route_list_generator.dart';
import 'package:dictionary_app/config/routing/init_route_list_generator.dart';
import 'package:dictionary_app/config/routing/language_selection_route_list_generator.dart';
import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MainRoutingConfig extends IocConfig {
  List<RouteListGenerator> getGenerators() {
    return [
      InitRouteListGenerator(),
      AuthRouteListGenerator(),
      LanguageSelectionRouteListGenerator()
    ];
  }

  @override
  void config() {
    GetIt.I.registerLazySingleton(() => GoRouter(
        routes: getGenerators().map((e) => e.generate()).fold(
            [], (previousValue, element) => previousValue..addAll(element))));
  }
}
