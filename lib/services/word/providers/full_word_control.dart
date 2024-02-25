import 'package:dictionary_app/accessors/word_utils_accessor.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/provider_commons/cache_for_extension.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'full_word_control.g.dart';

@riverpod
class FullWordControl extends _$FullWordControl with WordUtlsAccessor {
  @override
  Future<ApiPage<FullWordPart>> build(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    var result = (await wordDomainService())
        .searchForFullWordPartByName(namePattern, pageDetails: pageDetails);

    ref.cacheFor(const Duration(minutes: 1));

    return result;
  }
}
