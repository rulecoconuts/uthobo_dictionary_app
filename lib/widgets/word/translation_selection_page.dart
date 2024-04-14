import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/services/pagination/pagination_helper.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/helper_widgets/not_found_widget.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/shared_main_error_page.dart';
import 'package:dictionary_app/widgets/helper_widgets/shared_main_loading_widget.dart';
import 'package:dictionary_app/widgets/search/search_box_widget.dart';
import 'package:dictionary_app/widgets/word/translation_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/cupertino.dart' as cup;

class TranslationSelectionPage extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final String word;
  final PartOfSpeechDomainObject part;
  final Function(FullWordPart wordPart) onSubmit;
  final Function() onCancel;
  const TranslationSelectionPage(
      {required this.word,
      required this.part,
      required this.onSubmit,
      required this.onCancel,
      Key? key})
      : super(key: key);

  void goToTargetWordCreationPage(
      ValueNotifier<ApiPageDetails> currentPageDetails,
      ValueNotifier<String> searchString,
      ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
      ValueNotifier<FullWordPart?> selectedTranslation) {
    // Go to word creation page
    router().push("/target_word_creation", extra: <String, dynamic>{
      "on_submit": (word) {
        router().pop();
        addWord(
            word, currentPageDetails, searchString, pages, selectedTranslation);
      },
      "on_cancel": () => router().pop(),
      "search_string":
          PaginationHelper().sanitizeSearchString(searchString.value),
      "page_details": currentPageDetails.value
    });
  }

  void addWord(
      FullWordPart word,
      ValueNotifier<ApiPageDetails> currentPageDetails,
      ValueNotifier<String> searchString,
      ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
      ValueNotifier<FullWordPart?> selectedTranslation) {
    // Search for word exactly
    search(word.word.name, searchString, pages, currentPageDetails);
    if (word.containsPart(part)) {
      selectedTranslation.value = word;
    }
  }

  ApiPageDetails getFirstPageDetails() {
    return const ApiPageDetails(sortFields: [ApiSort(name: "name")]);
  }

  void save(ValueNotifier<FullWordPart?> selectedTranslation) {
    if (selectedTranslation.value == null) {
      ToastShower().showToast("No translation selected");
      return;
    }

    onSubmit(selectedTranslation.value!);
  }

  void goToEditWordPage(
    ValueNotifier<FullWordPart?> selectedTranslation,
    ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
  ) {}

  void showWordWithoutRequiredPartWarning(
    BuildContext context,
    FullWordPart fullWordPart,
    ValueNotifier<FullWordPart?> selectedTranslation,
    ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
  ) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return cup.CupertinoAlertDialog(
            title: Text(
              "Word is not a ${part.name}. Change that?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              cup.CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                isDefaultAction: true,
                child: Text("No",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.red)),
              ),
              cup.CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  // Go to edit page for word
                  goToEditWordPage(selectedTranslation, pages);
                },
                child: Text("Yes",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.blue)),
              )
            ],
          );
        });
  }

  /// Clear page and start new search
  void search(
      String newSearchStringValue,
      ValueNotifier<String> searchString,
      ValueNotifier<Map<int, ApiPage<FullWordPart>>> pages,
      ValueNotifier<ApiPageDetails> currentPageDetails) {
    pages.value.clear();
    currentPageDetails.value = getFirstPageDetails();
    searchString.value = newSearchStringValue;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translationContext = ref.watch(translationContextControlProvider);
    var searchString = useState("");

    if (translationContext.isLoading) {
      return const Center(
        child: SharedMainLoadingWidget(),
      );
    }

    if (translationContext.hasError) {
      return Center(
        child: SharedMainErrorPage(
          error: translationContext.error,
          stackTrace: translationContext.stackTrace,
        ),
      );
    }

    var currentPageDetails = useState(getFirstPageDetails());

    var lastFetchedPage = ref.watch(fullWordControlProvider(
        PaginationHelper().sanitizeSearchString(searchString.value),
        translationContext.value!.target,
        pageDetails: currentPageDetails.value));

    var pages = useState(<int, ApiPage<FullWordPart>>{});

    // Scrollable list controllers and listeners
    final itemScrollController = useState(ItemScrollController());
    final itemPositionsListener = useState(ItemPositionsListener.create());
    final scrollOffsetController = useState(ScrollOffsetController());
    final scrollOffsetListener = useState(ScrollOffsetListener.create());

    final selectedTranslation = useState<FullWordPart?>(null);

    if (lastFetchedPage.hasValue) {
      // Add newly added page to page map
      var newPageNumber = lastFetchedPage.value!.pageable.pageNumber;
      pages.value[newPageNumber] = lastFetchedPage.value!;
    }

    var translationOptions = PaginationHelper().flattenPageMap(pages.value);

    return Material(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => goToTargetWordCreationPage(
            currentPageDetails, searchString, pages, selectedTranslation),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 30),
            child: GoBackPanel(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
            child: Text(
              "Select translation of $word (${part.name}) in ${translationContext.value?.target.name}",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: SearchBoxWidget(
                        onSearchRequested: (val) => search(
                            val, searchString, pages, currentPageDetails))),
                if (lastFetchedPage.isLoading && translationOptions.isEmpty)
                  // INITIAL SEARCH LOADING
                  const Expanded(
                      child: Center(
                    child: SharedMainLoadingWidget(),
                  ))
                else if (lastFetchedPage.hasValue && translationOptions.isEmpty)
                  // NOT FOUND
                  const Expanded(
                      child: NotFoundWidget(
                          error:
                              "Could not find the word you were looking for? Create it!"))
                else
                  Expanded(
                      child: ScrollablePositionedList.separated(
                          itemScrollController: itemScrollController.value,
                          itemPositionsListener: itemPositionsListener.value,
                          scrollOffsetController: scrollOffsetController.value,
                          scrollOffsetListener: scrollOffsetListener.value,
                          itemCount: translationOptions.length,
                          itemBuilder: (ctx, index) {
                            var option = translationOptions[index];

                            return TranslationOptionWidget(
                              wordPart: option,
                              desiredPart: part,
                              isSelected: selectedTranslation.value == option,
                              onClicked: (containsPart) {
                                if (containsPart) {
                                  selectedTranslation.value = option;
                                } else {
                                  showWordWithoutRequiredPartWarning(context,
                                      option, selectedTranslation, pages);
                                }
                              },
                            );
                          },
                          separatorBuilder: (ctx, index) => const Padding(
                              padding: EdgeInsets.only(top: 20)))),
              ],
            ),
          )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(bottom: 40, top: 10),
              child: RoundedRectangleTextButton(
                  text: "Save", onPressed: () => save(selectedTranslation)))
        ],
      ),
    ));
  }
}
