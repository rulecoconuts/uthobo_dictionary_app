import 'dart:async';

import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/auth/login/auth.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginGateWidget extends StatefulWidget {
  const LoginGateWidget({super.key});

  @override
  State<LoginGateWidget> createState() => _LoginGateWidgetState();
}

class _LoginGateWidgetState extends State<LoginGateWidget>
    with RoutingUtilsAccessor, AuthUtilsAccessor {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 600), routeToAppropriatePage);
  }

  /// Decide which page the user should be sent to
  void routeToAppropriatePage() async {
    try {
      Auth? auth = await loginService().validateOrRefreshAuthInStorage(
          await authStorage(), Constants.loginTokenKey);

      if (auth == null) {
        // No auth
        router().go("/welcome");
        return;
      }

      // auth is valid

      // Go to home page
      router().go("/language_selection");
    } catch (e, stackTrace) {
      router().go("/welcome");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
