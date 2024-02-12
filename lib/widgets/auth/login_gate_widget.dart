import 'dart:async';

import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginGateWidget extends StatefulWidget {
  const LoginGateWidget({super.key});

  @override
  State<LoginGateWidget> createState() => _LoginGateWidgetState();
}

class _LoginGateWidgetState extends State<LoginGateWidget>
    with RoutingUtilsAccessor {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 600), routeToAppropriatePage);
  }

  /// Decide which page the user should be sent to
  void routeToAppropriatePage() {
    router().go("/welcome");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
