import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part_word_part_pair.g.dart';

@JsonSerializable()
class PartWordPartPair {
  WordPartDomainObject wordPart;
  PartOfSpeechDomainObject part;

  PartWordPartPair({required this.wordPart, required this.part});

  Map<String, dynamic> toJson() => _$PartWordPartPairToJson(this);

  factory PartWordPartPair.fromJson(Map<String, dynamic> json) =>
      _$PartWordPartPairFromJson(json);
}
