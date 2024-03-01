import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pronunciation_creation_request.g.dart';

@JsonSerializable()
class PronunciationCreationRequest {
  int? id;
  String? phoneticSpelling;
  String audioUrl;
  int? audioByteSize;
  String? audioFileType;
  int? audioMillisecondDuration;
  int? wordPartId;

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

  PronunciationCreationRequest(
      {this.id,
      this.phoneticSpelling,
      required this.audioUrl,
      this.audioByteSize,
      this.audioFileType,
      this.audioMillisecondDuration,
      this.wordPartId});

  Map<String, dynamic> toJson() => _$PronunciationCreationRequestToJson(this);

  factory PronunciationCreationRequest.fromJson(Map<String, dynamic> json) =>
      _$PronunciationCreationRequestFromJson(json);

  @override
  int get hashCode =>
      id == null ? Object.hash(audioUrl, null) : Object.hash(id, null);

  @override
  bool operator ==(dynamic other) =>
      other is PronunciationCreationRequest && other.hashCode == hashCode;
}
