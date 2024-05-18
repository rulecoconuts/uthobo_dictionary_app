import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';

abstract class TranslationService
    with
        CreationService<TranslationDomainObject>,
        UpdateService<TranslationDomainObject>,
        DeletionService<TranslationDomainObject> {
  Future<bool> isContextValid(TranslationContextDomainObject context);
}
