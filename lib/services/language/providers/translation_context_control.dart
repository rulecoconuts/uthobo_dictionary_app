import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_context_control.g.dart';

@riverpod
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
}
