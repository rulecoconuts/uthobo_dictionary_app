import 'package:json_annotation/json_annotation.dart';

part 'api_page_sort_details.g.dart';

@JsonSerializable()
class ApiPageSortDetails {
  final bool empty;
  final bool unsorted;
  final bool sorted;

  const ApiPageSortDetails(
      {this.empty = true, this.unsorted = true, this.sorted = false});

  Map<String, dynamic> toJson() => _$ApiPageSortDetailsToJson(this);

  factory ApiPageSortDetails.fromJson(Map<String, dynamic> json) =>
      _$ApiPageSortDetailsFromJson(json);
}
