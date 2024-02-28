import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_pronunciation.g.dart';

@JsonSerializable()
class RemotePronunciation {
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

  RemotePronunciation(
      {required this.audioUrl,
      required this.wordPartId,
      this.id,
      this.phoneticSpelling,
      this.audioByteSize,
      this.audioFileType,
      this.audioMillisecondDuration});

  Map<String, dynamic> toJson() => _$RemotePronunciationToJson(this);

  factory RemotePronunciation.fromJson(Map<String, dynamic> json) =>
      _$RemotePronunciationFromJson(json);
}
