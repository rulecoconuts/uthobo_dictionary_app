import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_part_of_speech.g.dart';

@JsonSerializable()
class RemotePartOfSpeech {
  int? id;
  String name;
  String? description;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  @override
  DateTime? createdAt;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  @override
  DateTime? updatedAt;

  @override
  int? createdBy;

  @override
  int? updatedBy;

  RemotePartOfSpeech(
      {this.id,
      required this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$RemotePartOfSpeechToJson(this);

  factory RemotePartOfSpeech.fromJson(Map<String, dynamic> json) =>
      _$RemotePartOfSpeechFromJson(json);

  PartOfSpeechDomainObject toDomain() {
    return PartOfSpeechDomainObject(
        name: name,
        id: id,
        description: description,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy);
  }

  factory RemotePartOfSpeech.fromDomain(PartOfSpeechDomainObject domain) {
    return RemotePartOfSpeech(
        name: domain.name,
        id: domain.id,
        description: domain.description,
        createdAt: domain.createdAt,
        createdBy: domain.createdBy,
        updatedAt: domain.updatedAt,
        updatedBy: domain.updatedBy);
  }
}
