import 'package:dictionary_app/services/auth/registration/user_registration_request.dart';

abstract interface class RegistrationService<
    T extends UserRegistrationRequest> {
  Future<bool> register(T registrationRequest);
}
