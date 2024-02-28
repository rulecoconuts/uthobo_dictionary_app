import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_creation_page.dart';
import 'package:go_router/src/route.dart';

class PronunciationRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() => [
        GoRoute(
            path: "/pronunciation_creation",
            builder: (context, state) {
              Map<String, dynamic> args = state.extra != null
                  ? state.extra as Map<String, dynamic>
                  : <String, dynamic>{};
              return PronunciationCreationPage(
                  wordCreationRequest: args["word_creation_request"],
                  part: args["part"],
                  onSubmit: args["on_submit"],
                  onCancel: args["on_cancel"]);
            })
      ];
}
