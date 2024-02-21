// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_page_sort_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPageSortDetails _$ApiPageSortDetailsFromJson(Map<String, dynamic> json) =>
    ApiPageSortDetails(
      empty: json['empty'] as bool? ?? true,
      unsorted: json['unsorted'] as bool? ?? true,
      sorted: json['sorted'] as bool? ?? false,
    );

Map<String, dynamic> _$ApiPageSortDetailsToJson(ApiPageSortDetails instance) =>
    <String, dynamic>{
      'empty': instance.empty,
      'unsorted': instance.unsorted,
      'sorted': instance.sorted,
    };
