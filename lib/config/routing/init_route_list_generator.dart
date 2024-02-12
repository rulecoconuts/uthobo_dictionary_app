import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/auth/login_gate_widget.dart';
import 'package:dictionary_app/widgets/welcome/welcome_page.dart';
import 'package:go_router/src/route.dart';

class InitRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
        path: "/",
        builder: (context, state) => LoginGateWidget(),
      ),
      GoRoute(
        path: "/welcome",
        builder: (context, state) => WelcomePage(),
      )
    ];
  }
}
