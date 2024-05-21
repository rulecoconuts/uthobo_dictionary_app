import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_result.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';

abstract interface class WordService
    with
        CreationService<WordDomainObject>,
        UpdateService<WordDomainObject>,
        DeletionService<WordDomainObject> {
  Future<ApiPage<FullWordPart>> searchForFullWordPartByName(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()});

  Future<ApiPage<FullWordPart>> searchForFullWordPartByNameInLanguage(
      String namePattern, LanguageDomainObject language,
      {ApiPageDetails pageDetails = const ApiPageDetails()});

  Future<WordCreationResult> createdWord(WordCreationRequest creationRequest);
}
