// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_word_part_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartWordPartPair _$PartWordPartPairFromJson(Map<String, dynamic> json) =>
    PartWordPartPair(
      wordPart: WordPartDomainObject.fromJson(
          json['wordPart'] as Map<String, dynamic>),
      part: PartOfSpeechDomainObject.fromJson(
          json['part'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartWordPartPairToJson(PartWordPartPair instance) =>
    <String, dynamic>{
      'wordPart': instance.wordPart,
      'part': instance.part,
    };
