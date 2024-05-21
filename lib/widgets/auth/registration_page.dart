import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/accessors/user_utils_accessor.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

class RegistrationPage extends HookWidget
    with RoutingUtilsAccessor, UserUtilsAccessor {
  const RegistrationPage({Key? key}) : super(key: key);

  Future register(
    GlobalKey<FormState> formKey,
    ValueNotifier<String> error,
    ValueNotifier<bool> isLoading,
    ValueNotifier<bool> shouldAutoValidateOnUserInteraction,
    Map<String, String> formContent,
  ) async {
    isLoading.value = true;
    try {
      if (!(formKey.currentState?.validate() ?? false)) return;

      RemoteAppUser user = RemoteAppUser(
        email: formContent['email']!,
        username: formContent["username"],
        firstName: formContent["first_name"],
        lastName: formContent["last_name"],
        password: formContent["password"],
      );

      await ((await userRESTService()).register(user));

      goToLoginPage();
    } on ApiError catch (e, stackTrace) {
      String message =
          e.errorMessages.keys.map((k) => e.errorMessages[k]!).join("\n");
      error.value =
          message.isEmpty ? e.message ?? "Something went wrong" : message;
    } catch (e, stackTrace) {
      error.value = "Something went wrong";
    } finally {
      isLoading.value = false;
      shouldAutoValidateOnUserInteraction.value = true;
    }
  }

  Function(String) generateCredentialsEditor(
      String key, ValueNotifier<Map<String, dynamic>> credentials) {
    return (value) => credentials.value[key] = value;
  }

  List<Widget> generateFormContent(
      ValueNotifier<Map<String, String>> credentials,
      ValueNotifier<bool> shouldAutoValidateOnUserInteraction,
      ValueNotifier<bool> isPasswordVisible) {
    return <Widget>[
      TextFormField(
        initialValue: credentials.value["email"],
        onChanged: generateCredentialsEditor("email", credentials),
        autovalidateMode: shouldAutoValidateOnUserInteraction.value
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: ValidationBuilder(
                optional: false, requiredMessage: "Email is required")
            .email("Email must be valid")
            .build(),
        decoration: InputDecoration(labelText: "Email"),
      ),
      TextFormField(
        initialValue: credentials.value["username"],
        onChanged: generateCredentialsEditor("username", credentials),
        autovalidateMode: shouldAutoValidateOnUserInteraction.value
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: ValidationBuilder(
                optional: false, requiredMessage: "Username is required")
            .maxLength(150, "Username cannot be more than 150 characters long")
            .build(),
        decoration: InputDecoration(labelText: "Username"),
      ),
      TextFormField(
        initialValue: credentials.value["first_name"],
        onChanged: generateCredentialsEditor("first_name", credentials),
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: shouldAutoValidateOnUserInteraction.value
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: ValidationBuilder(
                optional: false, requiredMessage: "First name is required")
            .maxLength(
                150, "First name cannot be more than 150 characters long")
            .build(),
        decoration: InputDecoration(labelText: "First name"),
      ),
      TextFormField(
        initialValue: credentials.value["last_name"],
        onChanged: generateCredentialsEditor("last_name", credentials),
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: shouldAutoValidateOnUserInteraction.value
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: ValidationBuilder(optional: true)
            .maxLength(150, "Last name cannot be more than 150 characters long")
            .build(),
        decoration: InputDecoration(labelText: "Lastname (optional)"),
      ),
      TextFormField(
        initialValue: credentials.value["password"],
        onChanged: generateCredentialsEditor("password", credentials),
        obscureText: !isPasswordVisible.value,
        autovalidateMode: shouldAutoValidateOnUserInteraction.value
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: ValidationBuilder(requiredMessage: "Password is required")
            .minLength(8, "Password must be 8-30 characters long")
            .maxLength(30, "Password must be 8-30 characters long")
            .build(),
        decoration: InputDecoration(
            labelText: "Password",
            suffixIcon: InkWell(
              onTap: () => isPasswordVisible.value = !isPasswordVisible.value,
              child: Icon(isPasswordVisible.value
                  ? Icons.visibility_off
                  : Icons.visibility),
            )),
      ),
      TextFormField(
        initialValue: credentials.value["password_confirmation"],
        onChanged:
            generateCredentialsEditor("password_confirmation", credentials),
        obscureText: !isPasswordVisible.value,
        autovalidateMode: shouldAutoValidateOnUserInteraction.value
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: ValidationBuilder(requiredMessage: "Passwords do not match")
            .regExp(RegExp('^(${credentials.value["password"]})\$' ?? r'^()$'),
                "Passwords do not match")
            .build(),
        decoration: InputDecoration(
            labelText: "Confirm Password",
            suffixIcon: InkWell(
              onTap: () => isPasswordVisible.value = !isPasswordVisible.value,
              child: Icon(isPasswordVisible.value
                  ? Icons.visibility_off
                  : Icons.visibility),
            )),
      ),
    ].separator(() => Padding(padding: EdgeInsets.only(top: 30))).toList();
  }

  void goToLoginPage() {
    router().go("/login");
  }

  @override
  Widget build(BuildContext context) {
    var formContent = useState(<String, String>{});
    var isPasswordVisible = useState(false);
    var error = useState("");
    var isLoading = useState(false);
    var credentials = useState(<String, String>{});
    var formKey = useState(GlobalKey<FormState>());
    var shouldAutoValidateOnUserInteraction = useState(false);
    return Material(
        child: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
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
                              padding: EdgeInsets.only(left: 50, bottom: 60),
                              child: Text(
                                "Register",
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: generateFormContent(
                                          credentials,
                                          shouldAutoValidateOnUserInteraction,
                                          isPasswordVisible),
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
                                padding: EdgeInsets.symmetric(horizontal: 15)
                                    .copyWith(top: 30),
                                child: Text(
                                  error.value,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.red),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15)
                                  .copyWith(top: 30),
                              child: InkWell(
                                  onTap: goToLoginPage,
                                  child: Text(
                                    "Already have an account? Sign in",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Color(0xFF628ED9)),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15)
                              .copyWith(bottom: 40, top: 50),
                          child: RoundedRectangleTextButton(
                            onPressed: () => register(
                                formKey.value,
                                error,
                                isLoading,
                                shouldAutoValidateOnUserInteraction,
                                credentials.value),
                            enabled: !isLoading.value,
                            text: "Register",
                          ))
                    ],
                  ),
                )
              ],
            )));
  }
}
