// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_username_password_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailUsernamePasswordAuth _$EmailUsernamePasswordAuthFromJson(
        Map<String, dynamic> json) =>
    EmailUsernamePasswordAuth(
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String,
    );

Map<String, dynamic> _$EmailUsernamePasswordAuthToJson(
    EmailUsernamePasswordAuth instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('username', instance.username);
  val['password'] = instance.password;
  val['type'] = instance.type;
  return val;
}
