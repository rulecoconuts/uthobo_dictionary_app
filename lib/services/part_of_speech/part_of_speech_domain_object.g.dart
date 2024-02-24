// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_of_speech_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartOfSpeechDomainObject _$PartOfSpeechDomainObjectFromJson(
        Map<String, dynamic> json) =>
    PartOfSpeechDomainObject(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
      createdBy: json['createdBy'] as int?,
      updatedBy: json['updatedBy'] as int?,
    );

Map<String, dynamic> _$PartOfSpeechDomainObjectToJson(
        PartOfSpeechDomainObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
