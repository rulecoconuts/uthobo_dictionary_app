import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/services/pagination/pagination_helper.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
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
      "on_submit": (word) {
        addWord(searchVal, word);
        router().pop();
      }
    });
  }

  void addWord(ValueNotifier<String> searchVal, FullWordPart word) {}

  ApiPageDetails getFirstPageDetails() {
    return const ApiPageDetails(sortFields: [ApiSort(name: "name")]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchVal = useState("");
    var currentPageDetails = useState(getFirstPageDetails());
    var translationContext = ref.watch(translationContextControlProvider);

    var lastFetchedPage = ref.watch(fullWordControlProvider(
        PaginationHelper().sanitizeSearchString(searchVal.value),
        translationContext.value!.target,
        pageDetails: currentPageDetails.value));

    var pages = useState(<int, ApiPage<FullWordPart>>{});

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
