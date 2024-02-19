// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSort _$ApiSortFromJson(Map<String, dynamic> json) => ApiSort(
      name: json['name'] as String,
      direction:
          $enumDecodeNullable(_$ApiSortDirectionEnumMap, json['direction']) ??
              ApiSortDirection.asc,
    );

Map<String, dynamic> _$ApiSortToJson(ApiSort instance) => <String, dynamic>{
      'name': instance.name,
      'direction': _$ApiSortDirectionEnumMap[instance.direction]!,
    };

const _$ApiSortDirectionEnumMap = {
  ApiSortDirection.asc: 'asc',
  ApiSortDirection.desc: 'desc',
};
