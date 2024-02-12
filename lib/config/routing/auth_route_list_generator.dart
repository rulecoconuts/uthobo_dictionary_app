import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/auth/login_page.dart';
import 'package:go_router/src/route.dart';

class AuthRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginPage(),
      )
    ];
  }
}
