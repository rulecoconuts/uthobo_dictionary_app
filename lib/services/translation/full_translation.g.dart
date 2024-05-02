// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullTranslation _$FullTranslationFromJson(Map<String, dynamic> json) =>
    FullTranslation(
      translation: TranslationDomainObject.fromJson(
          json['translation'] as Map<String, dynamic>),
      sourceWord:
          WordDomainObject.fromJson(json['sourceWord'] as Map<String, dynamic>),
      sourceWordPart: WordPartDomainObject.fromJson(
          json['sourceWordPart'] as Map<String, dynamic>),
      targetWord:
          WordDomainObject.fromJson(json['targetWord'] as Map<String, dynamic>),
      targetWordPart: WordPartDomainObject.fromJson(
          json['targetWordPart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FullTranslationToJson(FullTranslation instance) =>
    <String, dynamic>{
      'translation': instance.translation,
      'sourceWord': instance.sourceWord,
      'targetWord': instance.targetWord,
      'sourceWordPart': instance.sourceWordPart,
      'targetWordPart': instance.targetWordPart,
    };
