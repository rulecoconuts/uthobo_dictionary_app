import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'full_translation.g.dart';

@JsonSerializable()
class FullTranslation {
  TranslationDomainObject translation;
  WordDomainObject sourceWord;
  WordDomainObject targetWord;

  WordPartDomainObject sourceWordPart;

  WordPartDomainObject targetWordPart;

  FullTranslation(
      {required this.translation,
      required this.sourceWord,
      required this.sourceWordPart,
      required this.targetWord,
      required this.targetWordPart});

  @override
  int get hashCode => Object.hash(translation, null);

  @override
  bool operator ==(dynamic other) =>
      other is FullTranslation && other.hashCode == hashCode;

  bool contains(WordPartDomainObject wordPart) {
    return sourceWordPart == wordPart || targetWordPart == wordPart;
  }

  bool isReversed(LanguageDomainObject sourceLanguage) {
    if (targetWord.languageId == sourceLanguage.id) return true;

    if (sourceWord.languageId == sourceLanguage.id) return false;

    // Source language is neither the target nor the source
    throw Exception(
        "Language is neither the source nor the target in translation");
  }

  WordDomainObject deriveSourceWord(LanguageDomainObject sourceLanguage) {
    return isReversed(sourceLanguage) ? targetWord : sourceWord;
  }

  WordPartDomainObject deriveSourceWordPart(
      LanguageDomainObject sourceLanguage) {
    return isReversed(sourceLanguage) ? targetWordPart : sourceWordPart;
  }

  WordDomainObject deriveTargetWord(LanguageDomainObject sourceLanguage) {
    return isReversed(sourceLanguage) ? sourceWord : targetWord;
  }

  WordPartDomainObject deriveTargetWordPart(
      LanguageDomainObject sourceLanguage) {
    return isReversed(sourceLanguage) ? sourceWordPart : targetWordPart;
  }

  String? deriveNote(LanguageDomainObject sourceLanguage) {
    return isReversed(sourceLanguage)
        ? translation.reverseNote
        : translation.note;
  }

  void setNote(LanguageDomainObject sourceLanguage, String? note) {
    if (isReversed(sourceLanguage)) {
      translation.reverseNote = note;
    } else {
      translation.note = note;
    }
  }

  FullTranslation copyWithNote(
      LanguageDomainObject sourceLanguage, String? note) {
    return copy()..setNote(sourceLanguage, note);
  }

  FullTranslation copy() {
    return FullTranslation(
        translation: translation.copyWith(),
        sourceWord: sourceWord.copyWith(),
        sourceWordPart: sourceWordPart.copyWith(),
        targetWord: targetWord.copyWith(),
        targetWordPart: targetWordPart.copyWith());
  }

  Map<String, dynamic> toJson() => _$FullTranslationToJson(this);

  factory FullTranslation.fromJson(Map<String, dynamic> json) =>
      _$FullTranslationFromJson(json);
}
