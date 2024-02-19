// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPage<T> _$ApiPageFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiPage<T>(
      content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
      pageable:
          ApiPageDetails.fromJson(json['pageable'] as Map<String, dynamic>),
      totalPages: json['totalPages'] as int? ?? 0,
      totalElements: json['totalElements'] as int? ?? 0,
      last: json['last'] as bool? ?? false,
    );

Map<String, dynamic> _$ApiPageToJson<T>(
  ApiPage<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'content': instance.content.map(toJsonT).toList(),
      'pageable': instance.pageable,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'last': instance.last,
    };
