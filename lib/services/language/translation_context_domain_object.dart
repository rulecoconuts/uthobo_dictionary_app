import 'package:dictionary_app/services/language/language_domain_object.dart';

class TranslationContextDomainObject {
  final LanguageDomainObject source;
  final LanguageDomainObject target;

  TranslationContextDomainObject({required this.source, required this.target});

  TranslationContextDomainObject swap() {
    return TranslationContextDomainObject(source: target, target: source);
  }

  @override
  int get hashCode => Object.hash(source, target);

  @override
  bool operator ==(dynamic other) =>
      other is TranslationContextDomainObject && hashCode == other.hashCode;
}
