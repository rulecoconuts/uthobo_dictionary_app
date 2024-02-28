import 'package:dictionary_app/config/routing/route_list_generator.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_creation_page.dart';
import 'package:dictionary_app/widgets/word/word_creation_page.dart';
import 'package:dictionary_app/widgets/word/word_list_page.dart';
import 'package:go_router/src/route.dart';

class WordRouteListGenerator extends RouteListGenerator {
  @override
  List<RouteBase> generate() {
    return [
      GoRoute(
        path: "/word_list",
        builder: (context, state) {
          return WordListPage();
        },
      ),
      GoRoute(
          path: "/word_creation",
          builder: (context, state) {
            Map<String, dynamic> args = state.extra != null
                ? state.extra as Map<String, dynamic>
                : <String, dynamic>{};
            return WordCreationPage(
              searchString: args["search"],
            );
          }),
    ];
  }
}
