import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget with RoutingUtilsAccessor {
  const WelcomePage({super.key});

  void goToLogin() {
    router().go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 200, left: 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Welcome!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                              "Looking to create a digital dictionary?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Color(0xFF575353),
                                      fontWeight: FontWeight.w600),
                            )),
                      ]))),
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 40),
              child: TextButton(
                  onPressed: goToLogin,
                  child: Text(
                    "Get Started",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )))
        ],
      ),
    );
  }
}
