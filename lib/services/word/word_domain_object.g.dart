// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordDomainObject _$WordDomainObjectFromJson(Map<String, dynamic> json) =>
    WordDomainObject(
      id: json['id'] as int?,
      name: json['name'] as String,
      languageId: json['languageId'] as int,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
      createdBy: json['createdBy'] as int?,
      updatedBy: json['updatedBy'] as int?,
    );

Map<String, dynamic> _$WordDomainObjectToJson(WordDomainObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'languageId': instance.languageId,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
