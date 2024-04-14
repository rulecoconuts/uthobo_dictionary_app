import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/services/pagination/pagination_helper.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
import 'package:dictionary_app/widgets/helper_widgets/not_found_widget.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_card.dart';
import 'package:dictionary_app/widgets/helper_widgets/shared_main_loading_widget.dart';
import 'package:dictionary_app/widgets/search/search_box_widget.dart';
import 'package:dictionary_app/widgets/translation_context/translation_context_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class WordListPage extends HookConsumerWidget with RoutingUtilsAccessor {
  const WordListPage({Key? key}) : super(key: key);

  void goToWordCreationPage(
      ValueNotifier<String> searchVal,
      ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
      ValueNotifier<ApiPageDetails> pageDetails) {
    router().push("/word_creation", extra: <String, dynamic>{
      "search": searchVal.value,
      "on_submit": (word) {
        addWord(searchVal, pageDetails, pages, word);
        router().pop();
      }
    });
  }

  void addWord(
      ValueNotifier<String> searchVal,
      ValueNotifier<ApiPageDetails> pageDetails,
      ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
      FullWordPart word) {
    search(searchVal, pageDetails, word.word.name, pages);
  }

  void search(
    ValueNotifier<String> searchValNotif,
    ValueNotifier<ApiPageDetails> pageDetailsNotif,
    String searchVal,
    ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
  ) {
    searchValNotif.value = searchVal;
    pageDetailsNotif.value = getFirstPageDetails();
  }

  ApiPageDetails getFirstPageDetails() {
    return const ApiPageDetails(sortFields: [ApiSort(name: "name")]);
  }

  void fetchNextPage(
    ValueNotifier<ApiPageDetails> pageDetailsNotif,
    ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
  ) {
    pageDetailsNotif.value = PaginationHelper().getNextPageDetails(pages.value);
  }

  int maximumDistanceFromEndForSearch() {
    return 2;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchVal = useState("");
    var currentPageDetails = useState(getFirstPageDetails());
    var translationContext = ref.watch(translationContextControlProvider);

    if (translationContext.value == null)
      return const Center(
        child: SharedMainLoadingWidget(
          size: 100,
        ),
      );

    var pages = useState(<int, ApiPage<FullWordPart>>{});

    // Scrollable list controllers and listeners
    final itemScrollController = useState(ItemScrollController());
    final itemPositionsListener = useState(ItemPositionsListener.create());
    final scrollOffsetController = useState(ScrollOffsetController());
    final scrollOffsetListener = useState(ScrollOffsetListener.create());

    useEffect(() {
      pages.value = {};
      currentPageDetails.value = getFirstPageDetails();
    }, [translationContext.value]);

    useEffect(() {
      // Set up listeners to fetch next page when getting close to the end of the current page
      Function() onVisibleLanguagesChanged = () {
        PaginationHelper().performIfCloseToEnd(
            () => fetchNextPage(currentPageDetails, pages),
            itemPositionsListener.value,
            currentPageDetails.value,
            pages.value,
            maximumDistanceFromEndForSearch: maximumDistanceFromEndForSearch());
      };

      itemPositionsListener.value.itemPositions
          .addListener(onVisibleLanguagesChanged);

      return () => itemPositionsListener.value.itemPositions
          .removeListener(onVisibleLanguagesChanged);
    }, [itemPositionsListener.value.itemPositions]);

    var lastFetchedPage = ref.watch(fullWordControlProvider(
        PaginationHelper().sanitizeSearchString(searchVal.value),
        translationContext.value!.source,
        pageDetails: currentPageDetails.value));

    if (lastFetchedPage.hasValue) {
      // Add newly added page to page map
      var newPageNumber = lastFetchedPage.value!.pageable.pageNumber;
      pages.value[newPageNumber] = lastFetchedPage.value!;
    }

    var words = PaginationHelper().flattenPageMap(pages.value);

    return Material(
        child: Portal(
      child: Scaffold(
          floatingActionButton: FloatingActionButton.large(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () =>
                  goToWordCreationPage(searchVal, pages, currentPageDetails)),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TRANSLATION CONTEXT SETTINGS
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: TranslationContextWidget()),
                  // SEARCH BOX
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: SearchBoxWidget(
                        initialSearchString: searchVal.value,
                        onSearchRequested: (searchString) {
                          search(searchVal, currentPageDetails, searchString,
                              pages);
                        }),
                  ),
                  if (words.isEmpty && lastFetchedPage.hasValue)
                    // NOT FOUND
                    const Expanded(
                        child: NotFoundWidget(
                            error:
                                "Could not find the word you were looking for? Create it!"))
                  else if (words.isEmpty && lastFetchedPage.isLoading)
                    // INITIAL SEARCH LOADING
                    const Expanded(
                        child: Center(
                      child: SharedMainLoadingWidget(),
                    ))
                  else
                    // WORD LIST
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ScrollablePositionedList.separated(
                                itemCount: words.length,
                                itemBuilder: (context, index) {
                                  var word = words[index];
                                  return InkWell(
                                    child: RoundedRectangleTextCard(
                                        text: word.word.name),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)))))
                ],
              ))),
    ));
  }
}
