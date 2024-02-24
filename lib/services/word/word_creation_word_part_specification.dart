import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';

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
}
