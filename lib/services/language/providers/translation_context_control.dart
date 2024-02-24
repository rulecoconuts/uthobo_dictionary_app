import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_context_control.g.dart';

@Riverpod(keepAlive: true)
class TranslationContextControl extends _$TranslationContextControl {
  TranslationContextDomainObject? context;

  @override
  Future<TranslationContextDomainObject?> build() async {
    return context;
  }

  Future set(TranslationContextDomainObject context) async {
    this.context = context;
    ref.invalidateSelf();
  }

  Future setWith(
      {LanguageDomainObject? source, LanguageDomainObject? target}) async {
    state = AsyncValue.data(
        state.valueOrNull?.copyWith(source: source, target: target));
  }

  Future swap() async {
    state = AsyncValue.data(state.value?.swap());
  }
}
