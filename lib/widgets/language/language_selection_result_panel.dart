import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/providers/language_control.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/widgets/language/language_not_found_page.dart';
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
    return 2;
  }

  void search(ValueNotifier<ApiPageDetails> currentPageDetails,
      ValueNotifier<Map<int, ApiPage<LanguageDomainObject>>> pageMap) {
    var next = getNextPageDetails(pageMap);
    currentPageDetails.value = next;
  }

  ApiPageDetails getNextPageDetails(
      ValueNotifier<Map<int, ApiPage<LanguageDomainObject>>> pageMap) {
    // List<int> pageNumbers = pageMap.value.keys.toList();
    // pageNumbers.sort();
    // if (pageNumbers.isEmpty) return initialPageDetails;

    return (pageMap.value.entries
                .where((element) => element.value.content.isNotEmpty)
                .toList()
              ..sort((a, b) => a.key.compareTo(b.key)))
            .map((e) => e.value)
            .lastOrNull
            ?.pageable
            .next() ??
        initialPageDetails;
  }

  void fetchNewPageIfCloseToEnd(
      ItemPositionsListener itemPositionsListener,
      ValueNotifier<ApiPageDetails> currentPageDetails,
      ValueNotifier<Map<int, ApiPage<LanguageDomainObject>>> pageMap) {
    var languagePositions = itemPositionsListener.itemPositions.value;
    if (languagePositions.isEmpty) return;

    var languageList = getLanguageListFromPageMap(pageMap);

    int distanceFromEnd =
        languageList.length - languagePositions.last.index - 1;

    if (distanceFromEnd <= maximumDistanceFromEndForSearch()) {
      search(currentPageDetails, pageMap);
    }
  }

  void changeSelection(LanguageDomainObject language) {
    onSelectionChanged.call(language);
  }

  List<LanguageDomainObject> getLanguageListFromPageMap(
      ValueNotifier<Map<int, ApiPage<LanguageDomainObject>>> pageMap) {
    List<int> pageNumbers = pageMap.value.keys.toList();
    pageNumbers.sort();

    return pageNumbers
        .map((e) => pageMap.value[e]!.content)
        .fold([], (previousValue, element) => previousValue..addAll(element));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentPageDetails = useState(initialPageDetails);
    // var languageList = useState<List<LanguageDomainObject>>([]);
    var hasProcessedLastResult = useState(false);
    final ItemScrollController itemScrollController = ItemScrollController();
    final ScrollOffsetController scrollOffsetController =
        ScrollOffsetController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener =
        ScrollOffsetListener.create();
    var pageMap = useState(<int, ApiPage<LanguageDomainObject>>{});
    var fetchedResult = ref.watch(languageControlProvider(
        processSearchTerm(namePattern), currentPageDetails.value));

    // Listen to changes in visible items
    useEffect(() {
      Function() onVisibleLanguagesChanged = () => fetchNewPageIfCloseToEnd(
          itemPositionsListener, currentPageDetails, pageMap);

      itemPositionsListener.itemPositions
          .addListener(onVisibleLanguagesChanged);

      return () => itemPositionsListener.itemPositions
          .removeListener(onVisibleLanguagesChanged);
    }, [itemPositionsListener.itemPositions]);

    if (fetchedResult.hasValue) {
      var newPage = fetchedResult.value!;
      pageMap.value[newPage.pageable.pageNumber] = newPage;
    }

    final List<LanguageDomainObject> languageList =
        getLanguageListFromPageMap(pageMap);

    if (languageList.isEmpty && fetchedResult.isLoading) {
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

    if (languageList.isEmpty) {
      return LanguageNotFoundPage(
        previousSearchString: processSearchTerm(namePattern),
        previousPageDetails: currentPageDetails.value,
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: ScrollablePositionedList.separated(
        itemBuilder: (ctx, index) {
          var language = languageList[index];
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
        itemCount: languageList.length,
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
      )),
      if (fetchedResult.isLoading)
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Center(
            child: SizedBox(
                height: 50,
                width: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotateMultiple,
                  colors: [Theme.of(context).colorScheme.primary],
                )),
          ),
        )
    ]);
  }
}
