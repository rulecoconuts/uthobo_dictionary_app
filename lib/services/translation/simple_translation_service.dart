import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/server/simple_rest_service_backed_domain_service_mixin.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/translation/remote/remote_translation.dart';
import 'package:dictionary_app/services/translation/remote/translation_rest_service.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:dictionary_app/services/translation/translation_service.dart';

class SimpleTranslationService
    with
        CreationService<TranslationDomainObject>,
        UpdateService<TranslationDomainObject>,
        DeletionService<TranslationDomainObject>,
        SimpleRESTServiceBackedDomainServiceMixin<TranslationDomainObject,
            RemoteTranslation>
    implements
        TranslationService {
  final TranslationRESTService translationRESTService;

  const SimpleTranslationService({required this.translationRESTService});
  @override
  SimpleDioBackedRESTServiceMixin<RemoteTranslation> getRESTService() {
    return translationRESTService;
  }

  @override
  TranslationDomainObject toDomain(RemoteTranslation remote) {
    return remote.toDomain();
  }

  @override
  RemoteTranslation toRemote(TranslationDomainObject model) {
    return RemoteTranslation.fromDomain(model);
  }

  @override
  Future<bool> isContextValid(TranslationContextDomainObject context) async {
    return await translationRESTService.isContextValid(context);
  }
}
