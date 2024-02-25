import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_REST_service.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_service.dart';
import 'package:dictionary_app/services/part_of_speech/remote/remote_part_of_speech.dart';
import 'package:dictionary_app/services/part_of_speech/remote/simple_part_of_speech_REST_service.dart';
import 'package:dictionary_app/services/server/simple_rest_service_backed_domain_service_mixin.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';

class SimplePartOfSpeechService
    with
        CreationService<PartOfSpeechDomainObject>,
        UpdateService<PartOfSpeechDomainObject>,
        DeletionService<PartOfSpeechDomainObject>,
        SimpleRESTServiceBackedDomainServiceMixin<PartOfSpeechDomainObject,
            RemotePartOfSpeech>
    implements
        PartOfSpeechService {
  final SimplePartOfSpeechRESTService partOfSpeechRESTService;

  SimplePartOfSpeechService({required this.partOfSpeechRESTService});
  @override
  Future<ApiPage<PartOfSpeechDomainObject>> searchByNamePattern(
      String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    return (await partOfSpeechRESTService.searchByNamePattern(namePattern,
            pageDetails: pageDetails))
        .map((t) => t.toDomain());
  }

  @override
  SimpleDioBackedRESTServiceMixin<RemotePartOfSpeech> getRESTService() {
    return partOfSpeechRESTService;
  }

  @override
  PartOfSpeechDomainObject toDomain(RemotePartOfSpeech remote) {
    return remote.toDomain();
  }

  @override
  RemotePartOfSpeech toRemote(PartOfSpeechDomainObject model) {
    return RemotePartOfSpeech.fromDomain(model);
  }
}
