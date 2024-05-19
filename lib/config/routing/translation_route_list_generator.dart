import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:dictionary_app/widgets/translation_context/translation_context_gate_page.dart';
import 'package:dictionary_app/widgets/word/translation_selection_page.dart';
import 'package:go_router/src/route.dart';

class TranslationRouteListGenerator implements RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
        path: Constants.translationSelectionRoutePath,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;

          return TranslationSelectionPage(
              word: args["word"],
              part: args["part"],
              onSubmit: args["on_submit"],
              onCancel: args["on_cancel"]);
        },
      ),
      GoRoute(
          path: Constants.translationContextGateRoutePath,
          builder: (context, state) {
            return TranslationContextGatePage();
          })
    ];
  }
}
