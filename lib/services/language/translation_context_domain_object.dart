import 'package:dictionary_app/services/language/language_domain_object.dart';

class TranslationContextDomainObject {
  final LanguageDomainObject source;
  final LanguageDomainObject target;

  TranslationContextDomainObject({required this.source, required this.target});

  TranslationContextDomainObject swap() {
    return TranslationContextDomainObject(source: target, target: source);
  }

  TranslationContextDomainObject copyWith(
      {LanguageDomainObject? source, LanguageDomainObject? target}) {
    return TranslationContextDomainObject(
        source: source ?? this.source, target: target ?? this.target);
  }

  @override
  int get hashCode => Object.hash(source, target);

  @override
  bool operator ==(dynamic other) =>
      other is TranslationContextDomainObject && hashCode == other.hashCode;
}
