import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/accessors/word_utils_accessor.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/provider_commons/cache_for_extension.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_result.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'full_word_control.g.dart';

@riverpod
class FullWordControl extends _$FullWordControl
    with WordUtlsAccessor, PronunciationUtilsAccessor {
  @override
  Future<ApiPage<FullWordPart>> build(
      String namePattern, LanguageDomainObject languageDomainObject,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    var result = await (await wordDomainService())
        .searchForFullWordPartByNameInLanguage(
            namePattern, languageDomainObject,
            pageDetails: pageDetails);

    ref.cacheFor(const Duration(minutes: 1));

    return result;
  }

  /// Create a new word
  Future<WordCreationResult> createWord(
      WordCreationRequest wordCreationRequest) async {
    var result =
        await (await wordDomainService()).createdWord(wordCreationRequest);

    // Begin uploading pronunciations in the background
    (await pronunciationUploadScheduler())
        .scheduleAll(result.pronunciationPresignResults);

    ref.invalidateSelf();

    return result;
  }

  /// Update the properties of a word domain obejct
  Future<WordDomainObject> updateWordDomainObject(WordDomainObject word) async {
    return (await wordDomainService()).update(word);
  }

  Future<WordPartDomainObject> updateWordPart(
      WordPartDomainObject wordPart) async {
    return (await wordPartService()).update(wordPart);
  }

  Future<WordPartDomainObject> createWordPart(
      WordPartDomainObject model) async {
    return await (await wordPartService()).create(model);
  }
}
