import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_service.dart';
import 'package:dictionary_app/services/pronunciation/remote/pronunciation_rest_service.dart';
import 'package:dictionary_app/services/pronunciation/remote/remote_pronunciation.dart';
import 'package:dictionary_app/services/server/simple_rest_service_backed_domain_service_mixin.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';

class SimplePronunciationService
    with
        CreationService<PronunciationDomainObject>,
        UpdateService<PronunciationDomainObject>,
        DeletionService<PronunciationDomainObject>,
        SimpleRESTServiceBackedDomainServiceMixin<PronunciationDomainObject,
            RemotePronunciation>
    implements
        PronunciationService {
  PronunciationRESTService pronunciationRESTService;

  SimplePronunciationService({required this.pronunciationRESTService});
  @override
  SimpleDioBackedRESTServiceMixin<RemotePronunciation> getRESTService() {
    return pronunciationRESTService;
  }

  @override
  PronunciationDomainObject toDomain(RemotePronunciation remote) {
    return remote.toDomain();
  }

  @override
  RemotePronunciation toRemote(PronunciationDomainObject model) {
    return RemotePronunciation.fromDomain(model);
  }

  @override
  Future<PronunciationPresignResult> presign(
      PronunciationCreationRequest creationRequest) async {
    return await pronunciationRESTService.presign(creationRequest);
  }
}
