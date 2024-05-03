import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation_domain_object.g.dart';

@JsonSerializable()
class TranslationDomainObject {
  int? id;

  int sourceWordPartId;

  int targetWordPartId;
  String? note;
  String? reverseNote;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  DateTime? createdAt;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  DateTime? updatedAt;

  int? createdBy;
  int? updatedBy;

  TranslationDomainObject(
      {required this.sourceWordPartId,
      required this.targetWordPartId,
      this.id,
      this.note,
      this.reverseNote,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$TranslationDomainObjectToJson(this);

  factory TranslationDomainObject.fromJson(Map<String, dynamic> json) =>
      _$TranslationDomainObjectFromJson(json);

  TranslationDomainObject copyWith(
      {int? id,
      int? sourceWordPartId,
      int? targetWordPartId,
      String? note,
      String? reverseNote,
      DateTime? createdAt,
      int? createdBy,
      DateTime? updatedAt,
      int? updatedBy}) {
    return TranslationDomainObject(
        sourceWordPartId: sourceWordPartId ?? this.sourceWordPartId,
        targetWordPartId: targetWordPartId ?? this.targetWordPartId,
        id: id ?? this.id,
        note: note ?? this.note,
        reverseNote: reverseNote ?? this.reverseNote,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy);
  }

  @override
  int get hashCode => id != null
      ? Object.hash(id, null)
      : Object.hash(sourceWordPartId, targetWordPartId);

  @override
  bool operator ==(dynamic other) =>
      other is TranslationDomainObject && other.hashCode == hashCode;
}
