// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_creation_request_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCreationRequest _$WordCreationRequestFromJson(Map<String, dynamic> json) =>
    WordCreationRequest(
      name: json['name'] as String? ?? "",
      translationContext: TranslationContextDomainObject.fromJson(
          json['translationContext'] as Map<String, dynamic>),
      parts: (json['parts'] as List<dynamic>)
          .map((e) => WordCreationWordPartSpecification.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordCreationRequestToJson(
        WordCreationRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'translationContext': instance.translationContext,
      'parts': instance.parts,
    };
