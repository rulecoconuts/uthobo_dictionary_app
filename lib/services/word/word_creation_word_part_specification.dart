import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/word/word_creation_translation_specification.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_creation_word_part_specification.g.dart';

/// A word part specification that can only be used when creating words
@JsonSerializable()
class WordCreationWordPartSpecification {
  PartOfSpeechDomainObject part;
  String? definition;
  String? note;

  /// Pronunciations of the word part
  List<PronunciationCreationRequest> pronunciations = [];

  /// Translations of the word part
  List<WordCreationTranslationSpecification> translations = [];

  WordCreationWordPartSpecification(
      {required this.part, this.definition, this.note});

  Map<String, dynamic> toJson() =>
      _$WordCreationWordPartSpecificationToJson(this);

  factory WordCreationWordPartSpecification.fromJson(
          Map<String, dynamic> json) =>
      _$WordCreationWordPartSpecificationFromJson(json);
}
