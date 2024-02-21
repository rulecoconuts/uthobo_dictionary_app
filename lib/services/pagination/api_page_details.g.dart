// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_page_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPageDetails _$ApiPageDetailsFromJson(Map<String, dynamic> json) =>
    ApiPageDetails(
      pageNumber: json['pageNumber'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 20,
      offset: json['offset'] as int? ?? 0,
      paged: json['paged'] as bool? ?? true,
      unpaged: json['unpaged'] as bool? ?? false,
      sort: json['sort'] == null
          ? const ApiPageSortDetails()
          : ApiPageSortDetails.fromJson(json['sort'] as Map<String, dynamic>),
      sortFields: (json['sortFields'] as List<dynamic>?)
              ?.map(ApiSort.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ApiPageDetailsToJson(ApiPageDetails instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
      'sort': instance.sort,
      'sortFields': instance.sortFields,
    };
