import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/server/simple_rest_service_backed_domain_service_mixin.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/remote/remote_word.dart';
import 'package:dictionary_app/services/word/simple_word_REST_service.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_result.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word/word_service.dart';

class SimpleWordService
    with
        CreationService<WordDomainObject>,
        UpdateService<WordDomainObject>,
        DeletionService<WordDomainObject>,
        SimpleRESTServiceBackedDomainServiceMixin<WordDomainObject, RemoteWord>
    implements WordService {
  SimpleWordRESTService simpleWordRESTService;

  SimpleWordService({required this.simpleWordRESTService});
  @override
  Future<ApiPage<FullWordPart>> searchForFullWordPartByName(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    return await simpleWordRESTService.searchForFullWordPartByName(namePattern,
        pageDetails: pageDetails);
  }

  @override
  Future<ApiPage<FullWordPart>> searchForFullWordPartByNameInLanguage(
      String namePattern, LanguageDomainObject language,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    return await simpleWordRESTService.searchForFullWordPartByNameInLanguage(
        namePattern, language,
        pageDetails: pageDetails);
  }

  @override
  Future<WordCreationResult> createdWord(
      WordCreationRequest creationRequest) async {
    // Create word
    WordCreationResult result =
        await simpleWordRESTService.createWord(creationRequest);

    return result;
  }

  @override
  SimpleDioBackedRESTServiceMixin<RemoteWord> getRESTService() {
    return simpleWordRESTService;
  }

  @override
  WordDomainObject toDomain(RemoteWord remote) {
    return remote.toDomain();
  }

  @override
  RemoteWord toRemote(WordDomainObject model) {
    return RemoteWord.fromDomain(model);
  }
}
