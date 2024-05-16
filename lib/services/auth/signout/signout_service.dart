import 'package:dictionary_app/services/auth/storage/auth_storage.dart';

class SignoutService {
  AuthStorage authStorage;

  SignoutService({required this.authStorage});
  Future signout() async {
    await authStorage.clear();
  }
}
