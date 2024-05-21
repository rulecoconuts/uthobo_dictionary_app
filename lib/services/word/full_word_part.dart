import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word/part_word_part_pair.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'full_word_part.g.dart';

@JsonSerializable()
class FullWordPart {
  WordDomainObject word;
  List<PartWordPartPair> parts;

  FullWordPart({required this.word, this.parts = const []});

  Map<String, dynamic> toJson() => _$FullWordPartToJson(this);

  factory FullWordPart.fromJson(Map<String, dynamic> json) =>
      _$FullWordPartFromJson(json);

  bool containsPart(PartOfSpeechDomainObject part) {
    return parts.any((pair) => pair.part == part);
  }

  @override
  int get hashCode => Object.hash(word, null);

  @override
  bool operator ==(dynamic other) =>
      other is FullWordPart && hashCode == other.hashCode;

  WordPartDomainObject? getWordPart(PartOfSpeechDomainObject part) {
    return parts.where((element) => element.part == part).firstOrNull?.wordPart;
  }
}
