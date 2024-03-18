import 'package:dictionary_app/services/list/list_distinct_extension.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PaginationHelper {
  /// Flatten a map of pages into a sorted list of their contents.
  /// The key of the map is assumed to be the page number.
  List<T> flattenPageMap<T>(Map<int, ApiPage<T>> pages) {
    var sortedEntries = pages.entries
        .where((element) => element.value.content.isNotEmpty)
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries
        .map((e) => e.value.content)
        .fold(<T>[], (previousValue, element) => previousValue..addAll(element))
        .toList()
        .distinct();
  }

  /// Get next page details from a map of pages.
  /// The key of the map is assumed to be the page number.
  ApiPageDetails getNextPageDetails<T>(Map<int, ApiPage<T>> pages,
      {ApiPageDetails firstPageDetails = const ApiPageDetails()}) {
    var sortedEntries = pages.entries
        .where((element) => element.value.content.isNotEmpty)
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries.lastOrNull?.value.pageable.next() ?? firstPageDetails;
  }

  /// Perform a task if the scroll position is close to the end.
  /// Position is close if it is less than or equal to [maximumDistanceFromEndForSearch].
  void performIfCloseToEnd<T>(
      Function() task,
      ItemPositionsListener itemPositionsListener,
      ApiPageDetails currentPageDetails,
      Map<int, ApiPage<T>> pageMap,
      {int maximumDistanceFromEndForSearch = 5}) {
    var positions = itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    var contentList = PaginationHelper().flattenPageMap(pageMap);

    int distanceFromEnd = contentList.length - positions.last.index - 1;

    if (distanceFromEnd <= maximumDistanceFromEndForSearch) {
      task();
    }
  }
}
