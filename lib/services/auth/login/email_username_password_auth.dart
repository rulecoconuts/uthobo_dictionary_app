import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_username_password_auth.g.dart';

@JsonSerializable(includeIfNull: false)
class EmailUsernamePasswordAuth extends Auth {
  String? email;
  String? username;
  String password;
  EmailUsernamePasswordAuth({this.email, this.username, required this.password})
      : assert(
            email != null || username != null, "Username or email is required");

  Map<String, dynamic> toJson() => _$EmailUsernamePasswordAuthToJson(this);

  factory EmailUsernamePasswordAuth.fromJson(Map<String, dynamic> json) =>
      _$EmailUsernamePasswordAuthFromJson(json);

  @JsonKey(name: "type", includeToJson: true)
  @override
  String get type => EmailUsernamePasswordAuth.getType();

  static String getType() => "EmailUsernamePasswordAuth";
}
