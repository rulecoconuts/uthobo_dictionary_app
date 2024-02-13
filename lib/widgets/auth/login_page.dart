import 'dart:async';

import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/auth/auth.dart';
import 'package:dictionary_app/services/auth/email_username_password_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

class LoginPage extends HookWidget
    with AuthUtilsAccessor, RoutingUtilsAccessor {
  const LoginPage({Key? key}) : super(key: key);

  void login(
      GlobalKey<FormState> formKey,
      ValueNotifier<String> error,
      ValueNotifier<bool> isLoading,
      ValueNotifier<bool> shouldAutoValidateOnUserInteraction,
      Map<String, String> credentials) async {
    isLoading.value = true;
    error.value = "";

    try {
      // validate
      if (!(formKey.currentState?.validate() ?? false)) return;
      bool isUsingEmail = EmailValidator.validate(credentials["username"]!);
      // login
      Auth token = await loginService().login(EmailUsernamePasswordAuth(
          password: credentials["password"]!,
          email: isUsingEmail ? credentials["username"] : null,
          username: !isUsingEmail ? credentials["username"] : null));

      // if login is valid, store auth and go to login gate to be redirected to the appropriate page
      (await authStorage()).put("token", token);
      router().go("/");
    } finally {
      isLoading.value = false;
      shouldAutoValidateOnUserInteraction.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPasswordVisible = useState(false);
    var error = useState("");
    var isLoading = useState(false);
    var credentials = useState(<String, String>{});
    var formKey = useState(GlobalKey<FormState>());
    var shouldAutoValidateOnUserInteraction = useState(false);
    return Material(
        child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Main Body
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Padding(
                  padding: EdgeInsets.only(left: 50, bottom: 80),
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                // Form Widgets
                Form(
                    key: formKey.value,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: TextFormField(
                                  initialValue: credentials.value["username"],
                                  autovalidateMode:
                                      shouldAutoValidateOnUserInteraction.value
                                          ? AutovalidateMode.onUserInteraction
                                          : null,
                                  validator: ValidationBuilder(
                                          optional: false,
                                          requiredMessage:
                                              "Username or Email is required")
                                      .build(),
                                  decoration: InputDecoration(
                                      labelText: "Username or Email"),
                                )),
                            TextFormField(
                              initialValue: credentials.value["password"],
                              obscureText: !isPasswordVisible.value,
                              autovalidateMode:
                                  shouldAutoValidateOnUserInteraction.value
                                      ? AutovalidateMode.onUserInteraction
                                      : null,
                              validator: ValidationBuilder(
                                      requiredMessage: "Password is required")
                                  .build(),
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: () => isPasswordVisible.value =
                                        !isPasswordVisible.value,
                                    child: Icon(isPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  )),
                            )
                          ],
                        ))),
                if (isLoading.value)
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                if (error.value.isNotEmpty)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15).copyWith(top: 30),
                    child: Text(
                      error.value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  )
              ],
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 40),
              child: TextButton(
                  onPressed: isLoading.value
                      ? null
                      : () => login(
                          formKey.value,
                          error,
                          isLoading,
                          shouldAutoValidateOnUserInteraction,
                          credentials.value),
                  style: ButtonStyle(
                      backgroundColor: isLoading.value
                          ? MaterialStateProperty.all(Colors.grey)
                          : null),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  )))
        ],
      ),
    ));
  }
}
