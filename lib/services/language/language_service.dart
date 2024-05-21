import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/server/name_serchable_service.dart';

abstract interface class LanguageService
    implements
        CreationService<LanguageDomainObject>,
        NameSearchableService<LanguageDomainObject> {
  Future<ApiPage<LanguageDomainObject>> searchByNamePattern(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()});
}
