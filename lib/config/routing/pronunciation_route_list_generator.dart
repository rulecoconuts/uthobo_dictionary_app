import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_creation_page.dart';
import 'package:go_router/src/route.dart';

class PronunciationRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() => [
        GoRoute(
            path: Constants.pronunciationCreationRoutePath,
            builder: (context, state) {
              Map<String, dynamic> args = state.extra != null
                  ? state.extra as Map<String, dynamic>
                  : <String, dynamic>{};
              return PronunciationCreationPage(
                  wordName: args["word_name"],
                  part: args["part"],
                  initialPronunciationRequest:
                      args["initial_pronunciation_request"],
                  onSubmit: args["on_submit"],
                  onCancel: args["on_cancel"]);
            })
      ];
}
