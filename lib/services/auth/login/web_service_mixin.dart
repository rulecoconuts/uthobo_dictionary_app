import 'dart:io';

import 'package:dictionary_app/services/auth/login/auth.dart';

mixin AuthBackedWebServiceMixin {
  Future<Auth> getAuth();
  Future<Map<String, dynamic>> generateAuthHeaders();
  Future<Map<String, dynamic>> generateAuthHeadersFromSuppliedAuth(Auth auth);
}
