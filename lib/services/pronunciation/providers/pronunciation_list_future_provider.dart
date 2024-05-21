import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/accessors/word_utils_accessor.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/provider_commons/cache_for_extension.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pronunciation_list_future_provider.g.dart';

@riverpod
class PronunciationListFuture extends _$PronunciationListFuture
    with WordUtlsAccessor, PronunciationUtilsAccessor {
  @override
  Future<List<PronunciationDomainObject>> build(
      WordPartDomainObject wordPart) async {
    var pronunciations = (await wordPartService()).getPronunciations(wordPart);
    ref.cacheFor(const Duration(seconds: 30));

    return pronunciations;
  }

  Future delete(PronunciationDomainObject pronunciation) async {
    await (await pronunciationService()).delete(pronunciation);
    ref.invalidateSelf();
  }
}
