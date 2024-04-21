import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  @JsonKey(fromJson: SerializationUtils.forceDeserializeToString)
  final String? status;
  final DateTime? timestamp;
  final String? message;
  final String? debugMessage;

  final Map<String, String> errorMessages;

  ApiError(
      {required this.status,
      this.timestamp,
      this.message,
      this.debugMessage,
      this.errorMessages = const {}});

  String generateCompiledErrorMessages() {
    return errorMessages.keys.map((k) => errorMessages[k]!).join("\n");
  }

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
