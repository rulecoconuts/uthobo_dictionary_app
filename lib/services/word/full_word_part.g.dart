// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_word_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullWordPart _$FullWordPartFromJson(Map<String, dynamic> json) => FullWordPart(
      word: WordDomainObject.fromJson(json['word'] as Map<String, dynamic>),
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => PartWordPartPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FullWordPartToJson(FullWordPart instance) =>
    <String, dynamic>{
      'word': instance.word,
      'parts': instance.parts,
    };
