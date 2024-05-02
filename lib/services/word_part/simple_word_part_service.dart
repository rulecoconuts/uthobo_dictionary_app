import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/server/simple_rest_service_backed_domain_service_mixin.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';
import 'package:dictionary_app/services/translation/full_translation.dart';
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

  @override
  Future<List<PronunciationDomainObject>> getPronunciations(
      WordPartDomainObject wordPart) async {
    var remote = await wordPartRESTService
        .getPronunciations(RemoteWordPart.fromDomain(wordPart));

    return remote.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<FullTranslation>> getTranslations(
      WordPartDomainObject wordPart) async {
    return await wordPartRESTService
        .getTranslations(RemoteWordPart.fromDomain(wordPart));
  }
}
