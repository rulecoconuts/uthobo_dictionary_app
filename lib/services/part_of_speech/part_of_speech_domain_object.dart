import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part_of_speech_domain_object.g.dart';

@JsonSerializable()
class PartOfSpeechDomainObject implements TemporalAuditable, UserAuditable {
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

  PartOfSpeechDomainObject(
      {this.id,
      required this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$PartOfSpeechDomainObjectToJson(this);

  factory PartOfSpeechDomainObject.fromJson(Map<String, dynamic> json) =>
      _$PartOfSpeechDomainObjectFromJson(json);
}
