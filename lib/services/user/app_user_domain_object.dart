import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user_domain_object.g.dart';

@JsonSerializable()
class AppUserDomainObject {
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

  AppUserDomainObject(
      {required this.email,
      this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.password,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toJson() => _$AppUserDomainObjectToJson(this);

  factory AppUserDomainObject.fromJson(Map<String, dynamic> json) =>
      _$AppUserDomainObjectFromJson(json);
}
