import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';
import 'package:json_annotation/json_annotation.dart';
part 'word_creation_request_domain_object.g.dart';

@JsonSerializable()
class WordCreationRequest {
  String name;

  /// The translation context to use when creating the word.
  /// Word is created as part of the source language.
  /// Translations are created as part of the target language
  TranslationContextDomainObject translationContext;

  /// WordPart to be created to accompany thee word.
  /// At least one is required
  List<WordCreationWordPartSpecification> parts = [];

  WordCreationRequest(
      {this.name = "", required this.translationContext, required this.parts});

  Map<String, dynamic> toJson() => _$WordCreationRequestToJson(this);

  factory WordCreationRequest.fromJson(Map<String, dynamic> json) =>
      _$WordCreationRequestFromJson(json);
}
