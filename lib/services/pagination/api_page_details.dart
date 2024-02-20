import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_sort_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_page_details.g.dart';

@JsonSerializable()
class ApiPageDetails {
  final int pageNumber;
  final int pageSize;
  final int offset;
  final bool paged;
  final bool unpaged;

  /// General sort details
  final ApiPageSortDetails sort;

  /// Fields to be sorted
  final List<ApiSort> sortFields;

  const ApiPageDetails(
      {this.pageNumber = 0,
      this.pageSize = 20,
      this.offset = 0,
      this.paged = true,
      this.unpaged = false,
      this.sort = const ApiPageSortDetails(),
      this.sortFields = const []});

  ApiPageDetails first() {
    return ApiPageDetails(
        pageNumber: 0,
        pageSize: pageSize,
        offset: offset,
        paged: paged,
        unpaged: unpaged,
        sort: sort,
        sortFields: [...sortFields]);
  }

  ApiPageDetails next() {
    return ApiPageDetails(
        pageNumber: pageNumber + 1,
        pageSize: pageSize,
        offset: offset,
        paged: paged,
        unpaged: unpaged,
        sort: sort,
        sortFields: [...sortFields]);
  }

  ApiPageDetails previous() {
    return ApiPageDetails(
        pageNumber: pageNumber == 0 ? 0 : pageNumber - 1,
        pageSize: pageSize,
        offset: offset,
        paged: paged,
        unpaged: unpaged,
        sort: sort,
        sortFields: [...sortFields]);
  }

  Map<String, dynamic> toJson() => _$ApiPageDetailsToJson(this);

  factory ApiPageDetails.fromJson(Map<String, dynamic> json) =>
      _$ApiPageDetailsFromJson(json);

  Map<String, dynamic> toQueryParameters() {
    Map<String, dynamic> parameters = {
      "page": pageNumber.toString(),
      "size": pageSize.toString(),
      if (sortFields.isNotEmpty)
        "sort": sortFields.map((e) => e.toString()).toList()
    };

    return parameters;
  }
}
