import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/server/simple_rest_service_backed_domain_service_mixin.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/word_part/remote_word_part.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_rest_service.dart';
import 'package:dictionary_app/services/word_part/word_part_service.dart';

class SimpleWordPartService
    with
        CreationService<WordPartDomainObject>,
        UpdateService<WordPartDomainObject>,
        DeletionService<WordPartDomainObject>,
        SimpleRESTServiceBackedDomainServiceMixin<WordPartDomainObject,
            RemoteWordPart>
    implements
        WordPartService {
  final WordPartRESTService wordPartRESTService;

  SimpleWordPartService({required this.wordPartRESTService});
  @override
  SimpleDioBackedRESTServiceMixin<RemoteWordPart> getRESTService() {
    return wordPartRESTService;
  }

  @override
  WordPartDomainObject toDomain(RemoteWordPart remote) {
    return remote.toDomain();
  }

  @override
  RemoteWordPart toRemote(WordPartDomainObject model) {
    return RemoteWordPart.fromDomain(model);
  }
}
