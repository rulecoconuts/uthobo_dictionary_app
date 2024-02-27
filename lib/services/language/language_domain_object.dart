import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language_domain_object.g.dart';

@JsonSerializable()
class LanguageDomainObject implements TemporalAuditable, UserAuditable {
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

  LanguageDomainObject(
      {required this.name,
      this.id,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  @override
  int get hashCode =>
      id != null ? Object.hash(id, null) : Object.hash(name, null);

  @override
  bool operator ==(dynamic other) =>
      other is LanguageDomainObject && hashCode == other.hashCode;

  Map<String, dynamic> toJson() => _$LanguageDomainObjectToJson(this);

  factory LanguageDomainObject.fromJson(Map<String, dynamic> json) =>
      _$LanguageDomainObjectFromJson(json);
}
