import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/server/name_serchable_service.dart';

abstract interface class PartOfSpeechService
    implements
        NameSearchableService<PartOfSpeechDomainObject>,
        CreationService<PartOfSpeechDomainObject>,
        UpdateService<PartOfSpeechDomainObject>,
        DeletionService<PartOfSpeechDomainObject> {}
