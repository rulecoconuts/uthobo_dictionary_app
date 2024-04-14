import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_part_domain_object.g.dart';

@JsonSerializable()
class WordPartDomainObject {
  int? id;
  int wordId;
  int partId;
  String? definition;
  String? note;

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

  WordPartDomainObject(
      {this.id,
      required this.wordId,
      required this.partId,
      this.definition,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$WordPartDomainObjectToJson(this);

  factory WordPartDomainObject.fromJson(Map<String, dynamic> json) =>
      _$WordPartDomainObjectFromJson(json);
}