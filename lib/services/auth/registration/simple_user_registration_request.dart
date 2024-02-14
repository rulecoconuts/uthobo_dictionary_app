import 'package:dictionary_app/services/auth/registration/user_registration_request.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/remote_app_user.dart';

class SimpleUserRegistrationRequest implements UserRegistrationRequest {
  final RemoteAppUser user;
  SimpleUserRegistrationRequest({required this.user});
}
