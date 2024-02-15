import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_app_user.g.dart';

@JsonSerializable()
class RemoteAppUser {
  int? id;

  String? username;

  String email;

  String? firstName;

  String? lastName;

  String? password;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  DateTime? createdAt;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  DateTime? updatedAt;

  RemoteAppUser(
      {required this.email,
      this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.password,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toJson() => _$RemoteAppUserToJson(this);

  factory RemoteAppUser.fromJson(Map<String, dynamic> json) =>
      _$RemoteAppUserFromJson(json);
}
