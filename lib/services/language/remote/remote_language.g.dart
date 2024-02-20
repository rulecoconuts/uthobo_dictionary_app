// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteLanguage _$RemoteLanguageFromJson(Map<String, dynamic> json) =>
    RemoteLanguage(
      name: json['name'] as String,
      id: json['id'] as int?,
      description: json['description'] as String?,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
      createdBy: json['createdBy'] as int?,
      updatedBy: json['updatedBy'] as int?,
    );

Map<String, dynamic> _$RemoteLanguageToJson(RemoteLanguage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
