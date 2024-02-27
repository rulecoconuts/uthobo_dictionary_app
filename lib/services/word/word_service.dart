import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';

abstract interface class WordService {
  Future<ApiPage<FullWordPart>> searchForFullWordPartByName(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()});
}