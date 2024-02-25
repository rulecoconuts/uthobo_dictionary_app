import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'part_of_speech_creation_context.g.dart';

/// A provider that uniquely identifies and maintains a context for creation
/// of part of speech across pages
@riverpod
class PartOfSpeechCreationContext extends _$PartOfSpeechCreationContext {
  PartOfSpeechDomainObject? lastCreatedPart;

  @override
  PartOfSpeechDomainObject? build(String signature) {
    return lastCreatedPart;
  }

  void set(PartOfSpeechDomainObject createdPart) {
    lastCreatedPart = createdPart;
  }

  String generateSignature() {
    String dateString = DateTime.now().toIso8601String();

    return "${dateString}_${lastCreatedPart?.id}";
  }
}
