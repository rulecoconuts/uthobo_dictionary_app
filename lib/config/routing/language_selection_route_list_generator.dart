import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/selection/language_selection_page.dart';
import 'package:go_router/src/route.dart';

class LanguageSelectionRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
          path: "/language_selection",
          builder: (context, state) => LanguageSelectionPage())
    ];
  }
}
