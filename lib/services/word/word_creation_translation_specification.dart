import 'package:dictionary_app/services/word/word_domain_object.dart';

class WordCreationTranslationSpecification {
  String? note;

  WordDomainObject word;

// pronunciation | Pronunciation

  WordCreationTranslationSpecification({this.note, required this.word});
}
