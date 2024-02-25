import 'package:dictionary_app/services/part_of_speech/remote/remote_part_of_speech.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/name_serchable_service.dart';

abstract interface class PartOfSpeechRESTService
    implements NameSearchableService<RemotePartOfSpeech> {}
