// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteAppUser _$RemoteAppUserFromJson(Map<String, dynamic> json) =>
    RemoteAppUser(
      email: json['email'] as String,
      id: json['id'] as int?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      createdAt: SerializationUtils.deserializeDate(json['createdAt']),
      updatedAt: SerializationUtils.deserializeDate(json['updatedAt']),
    );

Map<String, dynamic> _$RemoteAppUserToJson(RemoteAppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'createdAt': SerializationUtils.serializeDate(instance.createdAt),
      'updatedAt': SerializationUtils.serializeDate(instance.updatedAt),
    };
