import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/config/routing/auth_route_list_generator.dart';
import 'package:dictionary_app/config/routing/init_route_list_generator.dart';
import 'package:dictionary_app/config/routing/language_selection_route_list_generator.dart';
import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/config/routing/word_route_list_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MainRoutingConfig extends IocConfig {
  List<RouteListGenerator> getGenerators() {
    return [
      InitRouteListGenerator(),
      AuthRouteListGenerator(),
      LanguageSelectionRouteListGenerator(),
      WordRouteListGenerator()
    ];
  }

  @override
  void config() {
    GetIt.I.registerLazySingleton(() => GoRouter(routes: [
          ShellRoute(
              builder: (context, state, child) {
                return Container(
                  color: Colors.white,
                  child: child,
                );
              },
              routes: getGenerators().map((e) => e.generate()).fold([],
                  (previousValue, element) => previousValue..addAll(element)))
        ]));
  }
}
