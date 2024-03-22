// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_creation_translation_specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCreationTranslationSpecification
    _$WordCreationTranslationSpecificationFromJson(Map<String, dynamic> json) =>
        WordCreationTranslationSpecification(
          note: json['note'] as String?,
          wordPart: WordPartDomainObject.fromJson(
              json['wordPart'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$WordCreationTranslationSpecificationToJson(
        WordCreationTranslationSpecification instance) =>
    <String, dynamic>{
      'note': instance.note,
      'wordPart': instance.wordPart,
    };
