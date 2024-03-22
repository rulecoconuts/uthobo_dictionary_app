// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_creation_word_part_specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCreationWordPartSpecification _$WordCreationWordPartSpecificationFromJson(
        Map<String, dynamic> json) =>
    WordCreationWordPartSpecification(
      part: PartOfSpeechDomainObject.fromJson(
          json['part'] as Map<String, dynamic>),
      definition: json['definition'] as String?,
      note: json['note'] as String?,
    )
      ..pronunciations = (json['pronunciations'] as List<dynamic>)
          .map((e) =>
              PronunciationCreationRequest.fromJson(e as Map<String, dynamic>))
          .toList()
      ..translations = (json['translations'] as List<dynamic>)
          .map((e) => WordCreationTranslationSpecification.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WordCreationWordPartSpecificationToJson(
        WordCreationWordPartSpecification instance) =>
    <String, dynamic>{
      'part': instance.part,
      'definition': instance.definition,
      'note': instance.note,
      'pronunciations': instance.pronunciations,
      'translations': instance.translations,
    };
