import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';

abstract interface class NameSearchableService<T> {
  Future<ApiPage<T>> searchByNamePattern(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()});
}
