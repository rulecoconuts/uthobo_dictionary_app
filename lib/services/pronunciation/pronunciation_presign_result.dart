import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pronunciation_presign_result.g.dart';

@JsonSerializable()
class PronunciationPresignResult {
  PronunciationDomainObject pronunciation;
  String presignedUrl;
  String destinationUrl;

  PronunciationPresignResult(
      {required this.pronunciation,
      required this.presignedUrl,
      required this.destinationUrl});

  Map<String, dynamic> toJson() => _$PronunciationPresignResultToJson(this);

  factory PronunciationPresignResult.fromJson(Map<String, dynamic> json) =>
      _$PronunciationPresignResultFromJson(json);

  @override
  int get hashCode => Object.hash(destinationUrl, null);

  @override
  bool operator ==(dynamic other) =>
      other is PronunciationPresignResult && other.hashCode == hashCode;
}
