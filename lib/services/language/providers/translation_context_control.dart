import 'dart:convert';

import 'package:dictionary_app/accessors/serialization_utils_accessor.dart';
import 'package:dictionary_app/accessors/storage_utils_accessor.dart';
import 'package:dictionary_app/accessors/translation_utils_accessor.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_context_control.g.dart';

@Riverpod(keepAlive: true)
class TranslationContextControl extends _$TranslationContextControl
    with
        StorageUtilsAccessor,
        SerializationUtilsAccessor,
        TranslationUtilsAccessor {
  TranslationContextDomainObject? context;
  String get localKey => "translation_context";

  @override
  Future<TranslationContextDomainObject?> build() async {
    // Attempt to retrive context from local storage
    var storage = await generalStorage();
    String? serial = await storage.get(localKey);
    TranslationContextDomainObject? translationContext = serial == null
        ? null
        : serializationUtils()
            .deserialize<TranslationContextDomainObject>(json.decode(serial));

    if (translationContext == null) return null;

    // If context exists locally, and it is valid return it
    bool isValid =
        await (await translationService()).isContextValid(translationContext);

    if (!isValid) {
      translationContext = null;
      await storage.delete(localKey);
    }

    context = translationContext;

    // else delete context
    return translationContext;
  }

  Future set(TranslationContextDomainObject context) async {
    this.context = context;
    ref.invalidateSelf();

    // Save context locally
    var storage = await generalStorage();
    await storage.put(
        localKey, json.encode(serializationUtils().serialize(context)));
  }

  Future setWith(
      {LanguageDomainObject? source, LanguageDomainObject? target}) async {
    state = AsyncValue.data(
        state.valueOrNull?.copyWith(source: source, target: target));
    context = state.value!;

    // Save context locally
    var storage = await generalStorage();
    await storage.put(
        localKey, json.encode(serializationUtils().serialize(context)));
  }

  Future swap() async {
    state = AsyncValue.data(state.value?.swap());
    context = state.value!;

    // Save context locally
    var storage = await generalStorage();
    await storage.put(
        localKey, json.encode(serializationUtils().serialize(context)));
  }
}
