// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_domain_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUserDomainObject _$AppUserDomainObjectFromJson(Map<String, dynamic> json) =>
    AppUserDomainObject(
      email: json['email'] as String,
      id: json['id'] as int?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AppUserDomainObjectToJson(
        AppUserDomainObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
