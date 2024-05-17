import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/providers/language_control.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/services/pagination/pagination_helper.dart';
import 'package:dictionary_app/widgets/helper_widgets/shared_main_loading_widget.dart';
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
  final Function(LanguageDomainObject newLanguage) onCreated;
  const LanguageSelectionResultPanel(
      {required this.namePattern,
      required this.onSelectionChanged,
      required this.onCreated,
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
    var next = PaginationHelper().getNextPageDetails(pageMap.value);
    currentPageDetails.value = next;
  }

  void changeSelection(LanguageDomainObject language) {
    onSelectionChanged.call(language);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentPageDetails = useState(initialPageDetails);
    // var languageList = useState<List<LanguageDomainObject>>([]);
    var hasProcessedLastResult = useState(false);

    final itemScrollController = useState(ItemScrollController());
    final scrollOffsetController = useState(ScrollOffsetController());
    final itemPositionsListener = useState(ItemPositionsListener.create());
    final scrollOffsetListener = useState(ScrollOffsetListener.create());
    var pageMap = useState(<int, ApiPage<LanguageDomainObject>>{});
    var fetchedResult = ref.watch(languageControlProvider(
        processSearchTerm(namePattern), currentPageDetails.value));

    // Listen to changes in visible items
    useEffect(() {
      Function() onVisibleLanguagesChanged = () {
        PaginationHelper().performIfCloseToEnd(
            () => search(currentPageDetails, pageMap),
            itemPositionsListener.value,
            currentPageDetails.value,
            pageMap.value,
            maximumDistanceFromEndForSearch: maximumDistanceFromEndForSearch());
      };

      itemPositionsListener.value.itemPositions
          .addListener(onVisibleLanguagesChanged);

      return () => itemPositionsListener.value.itemPositions
          .removeListener(onVisibleLanguagesChanged);
    }, [itemPositionsListener.value.itemPositions]);

    if (fetchedResult.hasValue) {
      var newPage = fetchedResult.value!;
      pageMap.value[newPage.pageable.pageNumber] = newPage;
    }

    final List<LanguageDomainObject> languageList =
        PaginationHelper().flattenPageMap(pageMap.value);

    if (languageList.isEmpty && fetchedResult.isLoading) {
      return const Center(
        child: SharedMainLoadingWidget(
          size: 100,
        ),
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
        itemScrollController: itemScrollController.value,
        scrollOffsetController: scrollOffsetController.value,
        itemPositionsListener: itemPositionsListener.value,
        scrollOffsetListener: scrollOffsetListener.value,
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
