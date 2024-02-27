import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';
import 'package:json_annotation/json_annotation.dart';
part 'word_creation_request_domain_object.g.dart';

@JsonSerializable()
class WordCreationRequest {
  String name;

  TranslationContextDomainObject translationContext;

  List<WordCreationWordPartSpecification> parts = [];

  WordCreationRequest(
      {this.name = "", required this.translationContext, required this.parts});

  Map<String, dynamic> toJson() => _$WordCreationRequestToJson(this);

  factory WordCreationRequest.fromJson(Map<String, dynamic> json) =>
      _$WordCreationRequestFromJson(json);
}
