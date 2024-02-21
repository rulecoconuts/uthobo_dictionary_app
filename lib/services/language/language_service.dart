import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';

abstract interface class LanguageService
    implements CreationService<LanguageDomainObject> {
  Future<ApiPage<LanguageDomainObject>> searchByNamePattern(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()});
}
