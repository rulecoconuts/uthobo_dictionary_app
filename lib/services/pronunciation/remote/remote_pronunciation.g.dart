// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_pronunciation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePronunciation _$RemotePronunciationFromJson(Map<String, dynamic> json) =>
    RemotePronunciation(
      audioUrl: json['audioUrl'] as String,
      wordPartId: json['wordPartId'] as int,
      id: json['id'] as int?,
      phoneticSpelling: json['phoneticSpelling'] as String?,
      audioByteSize: json['audioByteSize'] as int?,
      audioFileType: json['audioFileType'] as String?,
      audioMillisecondDuration: json['audioMillisecondDuration'] as int?,
    )
      ..createdAt = SerializationUtils.deserializeDate(json['createdAt'])
      ..updatedAt = SerializationUtils.deserializeDate(json['updatedAt'])
      ..createdBy = json['createdBy'] as int?
      ..updatedBy = json['updatedBy'] as int?;

Map<String, dynamic> _$RemotePronunciationToJson(
        RemotePronunciation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneticSpelling': instance.phoneticSpelling,
      'audioUrl': instance.audioUrl,
      'audioByteSize': instance.audioByteSize,
      'audioFileType': instance.audioFileType,
      'audioMillisecondDuration': instance.audioMillisecondDuration,
      'wordPartId': instance.wordPartId,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };
