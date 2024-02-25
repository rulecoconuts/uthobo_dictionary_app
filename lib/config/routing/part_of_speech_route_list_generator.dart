import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/part_of_speech/part_of_speech_creation_page.dart';
import 'package:dictionary_app/widgets/part_of_speech/part_of_speech_selection_page.dart';
import 'package:go_router/src/route.dart';

class PartOfSpeechRouteListGenerator implements RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
        path: "/part_of_speech_creation",
        builder: (context, state) => PartOfSpeechCreationPage(),
      ),
      GoRoute(
        path: "/part_of_speech_selection",
        builder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          return PartOfSpeechSelectionPage(
            onSelectionChanged: args["on_selection_changed"],
            onCancel: args["on_cancel"],
          );
        },
      )
    ];
  }
}
