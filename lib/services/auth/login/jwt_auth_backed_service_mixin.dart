import 'dart:io';

import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/auth/login/jwt_auth.dart';
import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';

mixin JwtAuthBackedServiceMixin on AuthBackedWebServiceMixin {
  @override
  Future<Map<String, dynamic>> generateAuthHeaders() async {
    return await generateAuthHeadersFromSuppliedAuth(await getAuth());
  }

  @override
  Future<Map<String, dynamic>> generateAuthHeadersFromSuppliedAuth(
      Auth auth) async {
    JwtAuth jwtAuth = auth as JwtAuth;
    return {
      HttpHeaders.authorizationHeader: "Bearer ${jwtAuth.token}",
      if (jwtAuth.refreshToken != null) "Refresh-Token": jwtAuth.refreshToken
    };
  }
}
