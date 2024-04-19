import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_word.g.dart';

@JsonSerializable()
class RemoteWord implements TemporalAuditable, UserAuditable {
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

  RemoteWord(
      {this.id,
      required this.name,
      required this.languageId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$RemoteWordToJson(this);

  factory RemoteWord.fromJson(Map<String, dynamic> json) =>
      _$RemoteWordFromJson(json);

  @override
  int get hashCode =>
      (id ?? 0) > 0 ? Object.hash(id, null) : Object.hash(name, languageId);

  @override
  bool operator ==(dynamic other) =>
      other is RemoteWord && hashCode == other.hashCode;

  WordDomainObject toDomain() {
    return WordDomainObject(
        name: name,
        languageId: languageId,
        id: id,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy);
  }

  factory RemoteWord.fromDomain(WordDomainObject domain) {
    return RemoteWord(
        name: domain.name,
        languageId: domain.languageId,
        id: domain.id,
        createdAt: domain.createdAt,
        createdBy: domain.createdBy,
        updatedAt: domain.updatedAt,
        updatedBy: domain.updatedBy);
  }
}
