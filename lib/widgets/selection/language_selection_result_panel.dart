import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/providers/language_control.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LanguageSelectionResultPanel extends HookConsumerWidget {
  final String namePattern;
  final ApiPageDetails initialPageDetails;
  final Function(LanguageDomainObject language) onSelectionChanged;
  const LanguageSelectionResultPanel(
      {required this.namePattern,
      required this.onSelectionChanged,
      this.initialPageDetails =
          const ApiPageDetails(sortFields: [ApiSort(name: "name")]),
      Key? key})
      : super(key: key);

  String processSearchTerm(String searchTerm) {
    return "%$searchTerm%";
  }

  int maximumDistanceFromEndForSearch() {
    return 4;
  }

  void search(ValueNotifier<ApiPageDetails> currentPageDetails,
      ValueNotifier<bool> hasProcessedLastResult) {
    currentPageDetails.value = currentPageDetails.value.next();
    hasProcessedLastResult.value = false;
  }

  void fetchNewPageIfCloseToEnd(
      ItemPositionsListener itemPositionsListener,
      ValueNotifier<ApiPageDetails> currentPageDetails,
      ValueNotifier<List<LanguageDomainObject>> languageList,
      ValueNotifier<bool> hasProcessedLastResult) {
    var languagePositions = itemPositionsListener.itemPositions.value;
    if (languagePositions.isEmpty) return;

    int distanceFromEnd =
        languageList.value.length - languagePositions.last.index - 1;

    if (distanceFromEnd <= maximumDistanceFromEndForSearch()) {
      search(currentPageDetails, hasProcessedLastResult);
    }
  }

  void changeSelection(LanguageDomainObject language) {
    onSelectionChanged.call(language);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentPageDetails = useState(initialPageDetails);
    var languageList = useState<List<LanguageDomainObject>>([]);
    var hasProcessedLastResult = useState(false);
    final ItemScrollController itemScrollController = ItemScrollController();
    final ScrollOffsetController scrollOffsetController =
        ScrollOffsetController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener =
        ScrollOffsetListener.create();
    var fetchedResult = ref.watch(languageControlProvider(
        processSearchTerm(namePattern), currentPageDetails.value));

    if (languageList.value.isEmpty && fetchedResult.isLoading) {
      return Center(
        child: SizedBox(
            height: 100,
            width: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [Theme.of(context).colorScheme.primary],
            )),
      );
    }

    // Listen to changes in visible items
    useEffect(() {
      Function() onVisibleLanguagesChanged = () => fetchNewPageIfCloseToEnd(
          itemPositionsListener,
          currentPageDetails,
          languageList,
          hasProcessedLastResult);

      return () => itemPositionsListener.itemPositions
          .removeListener(onVisibleLanguagesChanged);
    }, [itemPositionsListener.itemPositions]);

    if (fetchedResult.hasValue && !hasProcessedLastResult.value) {
      languageList.value.clear();
      var newList = fetchedResult.value!.content;
      languageList.value
          .addAll([...languageList.value, ...newList].toSet().toList());

      hasProcessedLastResult.value = true;

      if (newList.isEmpty) {
        currentPageDetails.value = currentPageDetails.value.previous();
      }
    }

    if (languageList.value.isEmpty) return Container();

    return ScrollablePositionedList.separated(
      itemBuilder: (ctx, index) {
        var language = languageList.value[index];
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: InkWell(
                onTap: () => changeSelection(language),
                child: Text("${language.name}",
                    style: Theme.of(context).textTheme.bodyMedium)));
      },
      separatorBuilder: (ctx, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Divider(
            thickness: 2,
          )),
      itemCount: languageList.value.length,
      itemScrollController: itemScrollController,
      scrollOffsetController: scrollOffsetController,
      itemPositionsListener: itemPositionsListener,
      scrollOffsetListener: scrollOffsetListener,
    );
  }
}
