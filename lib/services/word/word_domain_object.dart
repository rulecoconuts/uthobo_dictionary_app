import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_domain_object.g.dart';

@JsonSerializable()
class WordDomainObject implements TemporalAuditable, UserAuditable {
  int? id;
  String name;
  int languageId;

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

  WordDomainObject({
    this.id,
    required this.name,
    required this.languageId,
  });

  Map<String, dynamic> toJson() => _$WordDomainObjectToJson(this);

  factory WordDomainObject.fromJson(Map<String, dynamic> json) =>
      _$WordDomainObjectFromJson(json);

  @override
  int get hashCode =>
      (id ?? 0) > 0 ? Object.hash(id, null) : Object.hash(name, languageId);

  @override
  bool operator ==(dynamic other) =>
      other is WordDomainObject && hashCode == other.hashCode;
}
