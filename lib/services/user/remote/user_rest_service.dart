import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';

abstract interface class UserRESTService {
  Future<RemoteAppUser?> fetchLoggedInUserData();
  Future<RemoteAppUser?> fetchAuthUserData(Auth auth);
}
