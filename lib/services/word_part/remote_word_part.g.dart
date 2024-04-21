// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_word_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWordPart _$RemoteWordPartFromJson(Map<String, dynamic> json) =>
    RemoteWordPart(
      id: json['id'] as int?,
      wordId: json['wordId'] as int,
      partId: json['partId'] as int,
      definition: json['definition'] as String?,
      note: json['note'] as String?,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
      createdBy: json['createdBy'] as int?,
      updatedBy: json['updatedBy'] as int?,
    );

Map<String, dynamic> _$RemoteWordPartToJson(RemoteWordPart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wordId': instance.wordId,
      'partId': instance.partId,
      'definition': instance.definition,
      'note': instance.note,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
