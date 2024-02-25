import 'package:dictionary_app/services/word/part_word_part_pair.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
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
}
