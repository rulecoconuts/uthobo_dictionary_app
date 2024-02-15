// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JwtAuth _$JwtAuthFromJson(Map<String, dynamic> json) => JwtAuth(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$JwtAuthToJson(JwtAuth instance) => <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'type': instance.type,
    };
