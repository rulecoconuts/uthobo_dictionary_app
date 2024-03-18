import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/word/translation_selection_page.dart';
import 'package:go_router/src/route.dart';

class TranslationRouteListGenerator implements RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
        path: "/translation_selection",
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;

          return TranslationSelectionPage(
              word: args["word"],
              part: args["part"],
              onSubmit: args["on_submit"],
              onCancel: args["on_cancel"]);
        },
      )
    ];
  }
}
