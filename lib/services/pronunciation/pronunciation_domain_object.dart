import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pronunciation_domain_object.g.dart';

@JsonSerializable()
class PronunciationDomainObject {
  int? id;
  String? phoneticSpelling;
  String audioUrl;
  int? audioByteSize;
  String? audioFileType;
  int? audioMillisecondDuration;
  int wordPartId;

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

  PronunciationDomainObject(
      {required this.audioUrl,
      required this.wordPartId,
      this.id,
      this.phoneticSpelling,
      this.audioByteSize,
      this.audioFileType,
      this.audioMillisecondDuration});

  Map<String, dynamic> toJson() => _$PronunciationDomainObjectToJson(this);

  factory PronunciationDomainObject.fromJson(Map<String, dynamic> json) =>
      _$PronunciationDomainObjectFromJson(json);
}