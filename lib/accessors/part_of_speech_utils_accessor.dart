import 'package:dictionary_app/services/part_of_speech/part_of_speech_REST_service.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_service.dart';
import 'package:get_it/get_it.dart';

mixin PartOfSpeechUtilsAccessor {
  Future<PartOfSpeechRESTService> partOfSpeechRESTService() =>
      GetIt.I.getAsync<PartOfSpeechRESTService>();

  Future<PartOfSpeechService> partOfSpeechDomainService() =>
      GetIt.I.getAsync<PartOfSpeechService>();
}
