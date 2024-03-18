import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/simple_word_REST_service.dart';
import 'package:dictionary_app/services/word/word_service.dart';

class SimpleWordService implements WordService {
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
}
