import 'package:dictionary_app/services/word/simple_word_REST_service.dart';
import 'package:dictionary_app/services/word/word_service.dart';
import 'package:get_it/get_it.dart';

mixin WordUtlsAccessor {
  Future<SimpleWordRESTService> simpleWordRESTService() =>
      GetIt.I.getAsync<SimpleWordRESTService>();

  Future<WordService> wordDomainService() => GetIt.I.getAsync<WordService>();
}
