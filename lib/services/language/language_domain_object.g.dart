// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageDomainObject _$LanguageDomainObjectFromJson(
        Map<String, dynamic> json) =>
    LanguageDomainObject(
      name: json['name'] as String,
      id: json['id'] as int?,
      description: json['description'] as String?,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
      createdBy: json['createdBy'] as int?,
      updatedBy: json['updatedBy'] as int?,
    );

Map<String, dynamic> _$LanguageDomainObjectToJson(
        LanguageDomainObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
