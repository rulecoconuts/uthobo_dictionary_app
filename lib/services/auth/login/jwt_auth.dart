import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jwt_auth.g.dart';

@JsonSerializable()
class JwtAuth extends Auth {
  String token;

  JwtAuth({required this.token});

  @JsonKey(name: "type", includeToJson: true)
  @override
  String get type => JwtAuth.getType();

  Map<String, dynamic> toJson() => _$JwtAuthToJson(this);

  factory JwtAuth.fromJson(Map<String, dynamic> json) =>
      _$JwtAuthFromJson(json);

  static String getType() => "JwtAuth";
}
