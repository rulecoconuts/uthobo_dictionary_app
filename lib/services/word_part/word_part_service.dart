import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';

abstract interface class WordPartService
    with
        CreationService<WordPartDomainObject>,
        UpdateService<WordPartDomainObject>,
        DeletionService<WordPartDomainObject> {}
