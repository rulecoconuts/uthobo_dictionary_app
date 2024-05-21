// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_creation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCreationResult _$WordCreationResultFromJson(Map<String, dynamic> json) =>
    WordCreationResult(
      word: FullWordPart.fromJson(json['word'] as Map<String, dynamic>),
      pronunciationPresignResults: (json['pronunciationPresignResults']
              as List<dynamic>)
          .map((e) =>
              PronunciationPresignResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      translations: (json['translations'] as List<dynamic>)
          .map((e) =>
              TranslationDomainObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordCreationResultToJson(WordCreationResult instance) =>
    <String, dynamic>{
      'word': instance.word,
      'pronunciationPresignResults': instance.pronunciationPresignResults,
      'translations': instance.translations,
    };
