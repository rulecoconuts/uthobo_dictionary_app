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
}
