import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_translation.g.dart';

@JsonSerializable()
class RemoteTranslation implements UserAuditable, TemporalAuditable {
  int? id;

  int sourceWordPartId;

  int targetWordPartId;
  String? note;
  String? reverseNote;

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

  RemoteTranslation(
      {this.id,
      required this.sourceWordPartId,
      required this.targetWordPartId,
      this.note,
      this.reverseNote,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$RemoteTranslationToJson(this);

  factory RemoteTranslation.fromJson(Map<String, dynamic> json) =>
      _$RemoteTranslationFromJson(json);

  TranslationDomainObject toDomain() {
    return TranslationDomainObject(
        sourceWordPartId: sourceWordPartId,
        targetWordPartId: targetWordPartId,
        id: id,
        note: note,
        reverseNote: reverseNote,
        createdAt: createdAt,
        updatedAt: updatedAt,
        createdBy: createdBy,
        updatedBy: updatedBy);
  }

  factory RemoteTranslation.fromDomain(TranslationDomainObject domain) {
    return RemoteTranslation(
        sourceWordPartId: domain.sourceWordPartId,
        targetWordPartId: domain.targetWordPartId,
        id: domain.id,
        note: domain.note,
        reverseNote: domain.reverseNote,
        createdAt: domain.createdAt,
        updatedAt: domain.updatedAt,
        createdBy: domain.createdBy,
        updatedBy: domain.updatedBy);
  }
}
