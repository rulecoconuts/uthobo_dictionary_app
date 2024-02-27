// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_context_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationContextDomainObject _$TranslationContextDomainObjectFromJson(
        Map<String, dynamic> json) =>
    TranslationContextDomainObject(
      source:
          LanguageDomainObject.fromJson(json['source'] as Map<String, dynamic>),
      target:
          LanguageDomainObject.fromJson(json['target'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TranslationContextDomainObjectToJson(
        TranslationContextDomainObject instance) =>
    <String, dynamic>{
      'source': instance.source,
      'target': instance.target,
    };
