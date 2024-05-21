// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationDomainObject _$TranslationDomainObjectFromJson(
        Map<String, dynamic> json) =>
    TranslationDomainObject(
      sourceWordPartId: json['sourceWordPartId'] as int,
      targetWordPartId: json['targetWordPartId'] as int,
      id: json['id'] as int?,
      note: json['note'] as String?,
      reverseNote: json['reverseNote'] as String?,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
      createdBy: json['createdBy'] as int?,
      updatedBy: json['updatedBy'] as int?,
    );

Map<String, dynamic> _$TranslationDomainObjectToJson(
        TranslationDomainObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceWordPartId': instance.sourceWordPartId,
      'targetWordPartId': instance.targetWordPartId,
      'note': instance.note,
      'reverseNote': instance.reverseNote,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
