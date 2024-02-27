import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_creation_word_part_specification.g.dart';

@JsonSerializable()
class WordCreationWordPartSpecification {
  PartOfSpeechDomainObject part;
  String? definition;
  String? note;

// translations | WordCreationTranslationSpecification[]: [

// note: string,

// word_part | WordPart

// pronunciation | Pronunciation

// ]

  WordCreationWordPartSpecification(
      {required this.part, this.definition, this.note});

  Map<String, dynamic> toJson() =>
      _$WordCreationWordPartSpecificationToJson(this);

  factory WordCreationWordPartSpecification.fromJson(
          Map<String, dynamic> json) =>
      _$WordCreationWordPartSpecificationFromJson(json);
}
