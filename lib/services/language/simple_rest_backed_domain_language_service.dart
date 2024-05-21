import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/language_service.dart';
import 'package:dictionary_app/services/language/remote/language_rest_service.dart';
import 'package:dictionary_app/services/language/remote/remote_language.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';

class SimpleRESTBackedDomainLanguageService implements LanguageService {
  final LanguageRESTService languageRESTService;

  SimpleRESTBackedDomainLanguageService({required this.languageRESTService});

  @override
  Future<LanguageDomainObject> create(LanguageDomainObject model) async {
    return (await languageRESTService.create(RemoteLanguage.fromDomain(model)))
        .toDomain();
  }

  @override
  Future<ApiPage<LanguageDomainObject>> searchByNamePattern(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    return (await languageRESTService.searchByNamePattern(namePattern,
            pageDetails: pageDetails))
        .map((t) => t.toDomain());
  }

  @override
  Future<List<LanguageDomainObject>> createAll(
      List<LanguageDomainObject> models) {
    // TODO: implement createAll
    throw UnimplementedError();
  }
}
