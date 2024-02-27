import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/widgets/search/search_box_widget.dart';
import 'package:dictionary_app/widgets/translation_context/translation_context_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordListPage extends HookConsumerWidget with RoutingUtilsAccessor {
  const WordListPage({Key? key}) : super(key: key);

  void goToWordCreationPage(ValueNotifier<String> searchVal) {
    router().push("/word_creation", extra: <String, dynamic>{
      "search": searchVal.value,
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchVal = useState("");

    return Material(
        child: Portal(
      child: Scaffold(
          floatingActionButton: FloatingActionButton.large(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => goToWordCreationPage(searchVal)),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: TranslationContextWidget()),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: SearchBoxWidget(onSearchRequested: (searchString) {
                      searchVal.value = searchString;
                    }),
                  )
                ],
              ))),
    ));
  }
}
