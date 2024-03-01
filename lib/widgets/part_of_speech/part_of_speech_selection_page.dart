import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/part_of_speech/providers/part_of_speech_control.dart';
import 'package:dictionary_app/services/part_of_speech/providers/part_of_speech_creation_context.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/helper_widgets/not_found_widget.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_card.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_card.dart';
import 'package:dictionary_app/widgets/helper_widgets/shared_main_loading_widget.dart';
import 'package:dictionary_app/widgets/search/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PartOfSpeechSelectionPage extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final Function(PartOfSpeechDomainObject part) onSelectionSubmitted;
  final Function()? onCancel;
  const PartOfSpeechSelectionPage(
      {required this.onSelectionSubmitted, required this.onCancel, Key? key})
      : super(key: key);

  String processSearchString(String name) {
    return "%$name%";
  }

  /// Fetch data on next page
  Future fetchNextPage(
      ValueNotifier<Map<int, ApiPage<PartOfSpeechDomainObject>>> pages,
      ValueNotifier<ApiPageDetails> currentPageDetails) async {
    // Get last non-empty page
    currentPageDetails.value = ((pages.value.entries
                    .toList()
                    .where((entry) => entry.value.content.isNotEmpty)
                    .toList()
                  ..sort((a, b) => a.key.compareTo(b.key)))
                .lastOrNull
                ?.value
                .pageable ??
            currentPageDetails.value)
        .next();
  }

  /// Clear all results
  void reset(ValueNotifier<Map<int, ApiPage<PartOfSpeechDomainObject>>> pages,
      ValueNotifier<ApiPageDetails> currentPageDetails) async {
    // Delete search results for previous search string
    pages.value = {};
    currentPageDetails.value = getFirstPageDetails();
  }

  /// The details of the first page to be fetched always
  ApiPageDetails getFirstPageDetails() {
    return const ApiPageDetails(sortFields: [ApiSort(name: "name")]);
  }

  bool isPartAMatch(PartOfSpeechDomainObject part, String searchString) {
    String cleanedSearchString = searchString.replaceAll("%", "");

    return part.name.toLowerCase().contains(cleanedSearchString.toLowerCase());
  }

  /// Select new part and display it on the screen
  void addNewlyCreatedPartToList(
      PartOfSpeechDomainObject newPart,
      ValueNotifier<PartOfSpeechDomainObject?> selectedPart,
      ValueNotifier<PartOfSpeechDomainObject?> newPartNotifier,
      ValueNotifier<String> searchString,
      ValueNotifier<Map<int, ApiPage<PartOfSpeechDomainObject>>> pages,
      ValueNotifier<ApiPageDetails> currentPageDetails) {
    // Set new part as selected part
    selectedPart.value = newPart;
    String searchStringValue = searchString.value;

    if (isPartAMatch(newPart, searchStringValue)) {
      // If new part matches search string, wait for page to load, and try to scroll to it
      newPartNotifier.value = newPart;
    } else {
      // If new part does not match search string, perform new search with new part
      // name
      searchString.value = newPart.name;
      reset(pages, currentPageDetails);
    }
    Fluttertoast.showToast(msg: "Created part of speech");
  }

  void goToPartOfSpeechCreationPage(
    ValueNotifier<String> searchString,
    ValueNotifier<ApiPageDetails> currentPageDetails,
    ValueNotifier<PartOfSpeechDomainObject?> selectedPart,
    ValueNotifier<PartOfSpeechDomainObject?> newPartNotifier,
    ValueNotifier<Map<int, ApiPage<PartOfSpeechDomainObject>>> pages,
  ) {
    router().push("/part_of_speech_creation", extra: <String, dynamic>{
      "previous_search_string": processSearchString(searchString.value),
      "previous_page_details": currentPageDetails.value,
      "on_submit": (PartOfSpeechDomainObject newPart) {
        router().pop();
        addNewlyCreatedPartToList(newPart, selectedPart, newPartNotifier,
            searchString, pages, currentPageDetails);
      }
    });
  }

  /// Reduce pages into one sorted list of parts of speech
  List<PartOfSpeechDomainObject> getPartList(
      ValueNotifier<Map<int, ApiPage<PartOfSpeechDomainObject>>> pages) {
    return (pages.value.entries
            .where((element) => element.value.content.isNotEmpty)
            .toList()
          ..sort((a, b) => a.key.compareTo(b.key)))
        .fold(
            <PartOfSpeechDomainObject>[],
            (previousValue, element) =>
                previousValue..addAll(element.value.content))
        .toSet()
        .toList();
  }

  /// Select a part that was created in another page
  ProviderSubscription? selectNewlyCreatedPartIfItExists(
      ValueNotifier<PartOfSpeechDomainObject?> newPartNotifier,
      List<PartOfSpeechDomainObject> partList,
      ItemScrollController itemScrollController,
      AsyncValue<ApiPage<PartOfSpeechDomainObject>> lastFetchedPage,
      WidgetRef ref,
      ValueNotifier<String> searchString,
      ValueNotifier<ApiPageDetails> currentPageDetails) {
    PartOfSpeechDomainObject? newPart = newPartNotifier.value;
    if (newPart == null) return null;

    int index = partList.indexOf(newPart);

    ProviderSubscription? nextDataSubscription;

    if (index > -1) {
      // If the current list contains the new part, scroll to it.

      itemScrollController.scrollTo(
          index: index, duration: const Duration(milliseconds: 700));
    } else if (lastFetchedPage.isLoading) {
      // If the current list does not contain the new part, but new page is
      // loading, wait for page to load before checking again

      nextDataSubscription = ref
          .listenManual<AsyncValue<ApiPage<PartOfSpeechDomainObject>>>(
              partOfSpeechControlProvider(
                  processSearchString(searchString.value),
                  pageDetails: currentPageDetails.value), (prev, current) {
        if (current.hasValue) {
          // Next page has loaded. Attempt to scroll to new part if it exists
          // now and stop listening for new pages
          int newIndex = [...partList, ...current.value!.content]
              .toSet()
              .toList()
              .indexOf(newPart);

          if (newIndex > -1) {
            itemScrollController.scrollTo(
                index: index, duration: const Duration(milliseconds: 700));
          }
          nextDataSubscription?.close();
          return;
        }

        if (current.hasError) {
          // Encountered error while loading page. Stop listening for new pages
          nextDataSubscription?.close();
        }
      });
    }

    return nextDataSubscription;
  }

  /// Submit selection
  void save(ValueNotifier<PartOfSpeechDomainObject?> selectedPart) {
    if (selectedPart.value == null) {
      ToastShower().showToast("No part of speech selected");

      return;
    }

    onSelectionSubmitted.call(selectedPart.value!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchString = useState("");

    var pages = useState(<int, ApiPage<PartOfSpeechDomainObject>>{});
    var currentPageDetails = useState(getFirstPageDetails());
    var lastFetchedPage = ref.watch(partOfSpeechControlProvider(
        processSearchString(searchString.value),
        pageDetails: currentPageDetails.value));

    var selectedPart = useState<PartOfSpeechDomainObject?>(null);
    var newPart = useState<PartOfSpeechDomainObject?>(null);

    ItemScrollController itemScrollController = ItemScrollController();
    ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    ScrollOffsetController scrollOffsetController = ScrollOffsetController();
    ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

    useEffect(() {
      var searchForNewPattern = () {
        // New search string entered. Reset page
        reset(pages, currentPageDetails);
      };

      searchString.addListener(searchForNewPattern);

      return () => searchString.removeListener(searchForNewPattern);
    }, [searchString]);

    if (lastFetchedPage.hasValue) {
      // Add new result to state
      var newPage = lastFetchedPage.value!;
      pages.value[newPage.pageable.pageNumber] = newPage;
    }

    var partList = getPartList(pages);

    useEffect(() {
      // Select newly created part and scroll to it if necessary
      var newPageSubscription = selectNewlyCreatedPartIfItExists(
          newPart,
          partList,
          itemScrollController,
          lastFetchedPage,
          ref,
          searchString,
          currentPageDetails);

      return newPageSubscription?.close;
    }, [newPart.value]);

    return Material(
      child: Scaffold(
          floatingActionButton: FloatingActionButton.large(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => goToPartOfSpeechCreationPage(searchString,
                  currentPageDetails, selectedPart, newPart, pages)),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: GoBackPanel(
                  onTap: onCancel,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Text(
                        "Select Part of Speech",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10)
                          .copyWith(bottom: 30),
                      child: SearchBoxWidget(
                          onSearchRequested: (searchVal) =>
                              searchString.value = searchVal),
                    ),
                    if (lastFetchedPage.isLoading && partList.isEmpty)
                      const Expanded(
                          child: Center(
                        child: SharedMainLoadingWidget(),
                      ))
                    else if (lastFetchedPage.hasValue && partList.isEmpty)
                      const Expanded(
                          child: NotFoundWidget(
                              error:
                                  "Could not find the part of speech you were looking for?  Create it!"))
                    else
                      Expanded(
                          child: ScrollablePositionedList.separated(
                              scrollOffsetController: scrollOffsetController,
                              scrollOffsetListener: scrollOffsetListener,
                              itemScrollController: itemScrollController,
                              itemPositionsListener: itemPositionsListener,
                              itemCount: partList.length,
                              itemBuilder: (ctx, index) {
                                var part = partList[index];
                                return InkWell(
                                    onTap: () => selectedPart.value = part,
                                    child: RoundedRectangleTextCard(
                                        filled: part == selectedPart.value,
                                        text: part.name));
                              },
                              separatorBuilder: (ctx, index) => const Padding(
                                  padding: EdgeInsets.only(top: 30)))),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 40, top: 10),
                        child: RoundedRectangleTextButton(
                            text: "Save", onPressed: () => save(selectedPart)))
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
