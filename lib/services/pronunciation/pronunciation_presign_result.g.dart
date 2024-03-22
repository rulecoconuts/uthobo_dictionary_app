// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation_presign_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PronunciationPresignResult _$PronunciationPresignResultFromJson(
        Map<String, dynamic> json) =>
    PronunciationPresignResult(
      pronunciation: PronunciationDomainObject.fromJson(
          json['pronunciation'] as Map<String, dynamic>),
      presignedUrl: json['presignedUrl'] as String,
      destinationUrl: json['destinationUrl'] as String,
    );

Map<String, dynamic> _$PronunciationPresignResultToJson(
        PronunciationPresignResult instance) =>
    <String, dynamic>{
      'pronunciation': instance.pronunciation,
      'presignedUrl': instance.presignedUrl,
      'destinationUrl': instance.destinationUrl,
    };
