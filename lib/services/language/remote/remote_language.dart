import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_language.g.dart';

@JsonSerializable()
class RemoteLanguage implements TemporalAuditable, UserAuditable {
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

  RemoteLanguage(
      {required this.name,
      this.id,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$RemoteLanguageToJson(this);

  factory RemoteLanguage.fromJson(Map<String, dynamic> json) =>
      _$RemoteLanguageFromJson(json);

  LanguageDomainObject toDomain() {
    return LanguageDomainObject(
        name: name,
        id: id,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
        createdBy: createdBy,
        updatedBy: updatedBy);
  }

  factory RemoteLanguage.fromDomain(LanguageDomainObject languageDomainObject) {
    return RemoteLanguage(
        name: languageDomainObject.name,
        id: languageDomainObject.id,
        description: languageDomainObject.description,
        createdAt: languageDomainObject.createdAt,
        updatedAt: languageDomainObject.updatedAt,
        createdBy: languageDomainObject.createdBy,
        updatedBy: languageDomainObject.updatedBy);
  }
}
