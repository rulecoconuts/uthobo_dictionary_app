import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_creation_translation_specification.g.dart';

@JsonSerializable()
class WordCreationTranslationSpecification {
  String? note;

  @JsonKey(includeFromJson: false, includeToJson: false)
  FullWordPart? word;

  WordPartDomainObject wordPart;

  WordCreationTranslationSpecification(
      {this.note, required this.wordPart, this.word});

  Map<String, dynamic> toJson() =>
      _$WordCreationTranslationSpecificationToJson(this);

  factory WordCreationTranslationSpecification.fromJson(
          Map<String, dynamic> json) =>
      _$WordCreationTranslationSpecificationFromJson(json);
}
