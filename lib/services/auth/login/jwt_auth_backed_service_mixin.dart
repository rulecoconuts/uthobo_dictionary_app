import 'dart:io';

import 'package:dictionary_app/services/auth/login/jwt_auth.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';

mixin JwtAuthBackedServiceMixin on AuthBackedWebServiceMixin {
  @override
  Future<Map<String, dynamic>> generateAuthHeaders() async {
    JwtAuth jwtAuth = (await getAuth()) as JwtAuth;
    return {
      HttpHeaders.authorizationHeader: "Bearer ${jwtAuth.token}",
      if (jwtAuth.refreshToken != null) "Refresh-Token": jwtAuth.refreshToken
    };
  }
}
