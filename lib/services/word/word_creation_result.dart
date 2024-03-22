import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_creation_result.g.dart';

@JsonSerializable()
class WordCreationResult {
  FullWordPart word;
  List<PronunciationPresignResult> pronunciationPresignResults;
  List<TranslationDomainObject> translationDomainObject;

  WordCreationResult(
      {required this.word,
      required this.pronunciationPresignResults,
      required this.translationDomainObject});

  Map<String, dynamic> toJson() => _$WordCreationResultToJson(this);

  factory WordCreationResult.fromJson(Map<String, dynamic> json) =>
      _$WordCreationResultFromJson(json);
}
