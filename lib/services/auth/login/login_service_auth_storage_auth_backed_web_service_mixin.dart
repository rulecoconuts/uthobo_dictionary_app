import 'package:dictionary_app/services/auth/error_handling/invalid_auth_exception.dart';
import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/login_service.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/constants/constants.dart';

mixin LoginServiceAuthStorageAuthBackedWebServiceMixin
    on AuthBackedWebServiceMixin {
  Future<LoginService> getLoginService();

  Future<AuthStorage> getAuthStorage();

  @override
  Future<Auth> getAuth() async {
    var auth = await ((await getLoginService()).validateOrRefreshAuthInStorage(
        await getAuthStorage(), Constants.loginTokenKey));

    if (auth == null) throw InvalidAuthException(message: "No Auth");

    return auth;
  }
}
