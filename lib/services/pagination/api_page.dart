import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_page.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiPage<T> {
  final List<T> content;
  final ApiPageDetails pageable;
  int totalPages;
  int totalElements;
  bool last;

  ApiPage(
      {required this.content,
      required this.pageable,
      this.totalPages = 0,
      this.totalElements = 0,
      this.last = false});

  Map<String, dynamic> toJson(Object? Function(T value) serializer) =>
      _$ApiPageToJson(this, serializer);

  factory ApiPage.fromJson(
          Map<String, dynamic> json, T Function(Object? value) deserializer) =>
      _$ApiPageFromJson(json, deserializer);
}
