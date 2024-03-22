import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_creation_translation_specification.g.dart';

@JsonSerializable()
class WordCreationTranslationSpecification {
  String? note;

  WordPartDomainObject wordPart;

  WordCreationTranslationSpecification({this.note, required this.wordPart});

  Map<String, dynamic> toJson() =>
      _$WordCreationTranslationSpecificationToJson(this);

  factory WordCreationTranslationSpecification.fromJson(
          Map<String, dynamic> json) =>
      _$WordCreationTranslationSpecificationFromJson(json);
}
