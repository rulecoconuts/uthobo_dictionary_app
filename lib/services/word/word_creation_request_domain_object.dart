import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';

class WordCreationRequest {
  String name;

  TranslationContextDomainObject translationContext;

  List<WordCreationWordPartSpecification> parts;

  WordCreationRequest(
      {this.name = "",
      required this.translationContext,
      this.parts = const []});
}
