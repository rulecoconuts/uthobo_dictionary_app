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
        EmailUsernamePasswordAuth instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'type': instance.type,
    };
