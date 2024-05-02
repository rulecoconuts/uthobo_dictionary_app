import 'package:dictionary_app/accessors/word_utils_accessor.dart';
import 'package:dictionary_app/services/provider_commons/cache_for_extension.dart';
import 'package:dictionary_app/services/translation/full_translation.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_list_future_provider.g.dart';

@riverpod
class TranslationListFuture extends _$TranslationListFuture
    with WordUtlsAccessor {
  @override
  Future<List<FullTranslation>> build(WordPartDomainObject wordPart) async {
    List<FullTranslation> translations =
        await (await wordPartService()).getTranslations(wordPart);

    ref.cacheFor(const Duration(seconds: 30));

    return translations;
  }

  Future<TranslationDomainObject> updateTranslation(
      TranslationDomainObject translationDomainObject) async {
    // TODO: Call translation service update method
    throw UnimplementedError();
  }
}
