import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/language/language_creation_page.dart';
import 'package:dictionary_app/widgets/language/language_selection_page.dart';
import 'package:go_router/src/route.dart';

class LanguageSelectionRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
          path: "/language_selection",
          builder: (context, state) => LanguageSelectionPage()),
      GoRoute(
          path: "/language_create",
          builder: (context, state) {
            Map<String, dynamic> args =
                state.extra == null ? {} : state.extra as Map<String, dynamic>;
            return LanguageCreationPage(
              previousSearchString: args["previous_search_string"],
              previousPageDetails: args["previous_page_details"],
            );
          }),
    ];
  }
}
