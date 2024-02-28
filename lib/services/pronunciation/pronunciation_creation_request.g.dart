// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation_creation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PronunciationCreationRequest _$PronunciationCreationRequestFromJson(
        Map<String, dynamic> json) =>
    PronunciationCreationRequest(
      id: json['id'] as int?,
      phoneticSpelling: json['phoneticSpelling'] as String?,
      audioUrl: json['audioUrl'] as String,
      audioByteSize: json['audioByteSize'] as int?,
      audioFileType: json['audioFileType'] as String?,
      audioMillisecondDuration: json['audioMillisecondDuration'] as int?,
      wordPartId: json['wordPartId'] as int?,
    )
      ..createdAt = SerializationUtils.deserializeDate(json['createdAt'])
      ..updatedAt = SerializationUtils.deserializeDate(json['updatedAt'])
      ..createdBy = json['createdBy'] as int?
      ..updatedBy = json['updatedBy'] as int?;

Map<String, dynamic> _$PronunciationCreationRequestToJson(
        PronunciationCreationRequest instance) =>
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
