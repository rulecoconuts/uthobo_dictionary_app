import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';

abstract class PronunciationService
    with
        CreationService<PronunciationDomainObject>,
        UpdateService<PronunciationDomainObject>,
        DeletionService<PronunciationDomainObject> {}
