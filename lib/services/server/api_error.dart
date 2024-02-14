import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  final String status;
  final DateTime? timestamp;
  final String? message;
  final String? debugMessage;
  final Map<String, String> errorMessages = {};

  ApiError({
    required this.status,
    this.timestamp,
    this.message,
    this.debugMessage,
  });

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
