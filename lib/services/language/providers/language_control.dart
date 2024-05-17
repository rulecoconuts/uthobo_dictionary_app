import 'package:dictionary_app/accessors/language_utils_accessor.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/provider_commons/cache_for_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_control.g.dart';

@riverpod
class LanguageControl extends _$LanguageControl with LanguageUtilsAccessor {
  @override
  Future<ApiPage<LanguageDomainObject>> build(
      String namePattern, ApiPageDetails pageDetails) async {
    var results = await (await languageDomainService())
        .searchByNamePattern(namePattern, pageDetails: pageDetails);

    if (results.content.isNotEmpty) {
      ref.cacheFor(Duration(seconds: 15));
    }

    return results;
  }

  Future<LanguageDomainObject> create(LanguageDomainObject newLanguage) async {
    LanguageDomainObject created =
        await (await languageDomainService()).create(newLanguage);
    ref.invalidateSelf();

    return created;
  }
}
