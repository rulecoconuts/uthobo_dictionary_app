import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/form/form_helper.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/providers/language_control.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageCreationPage extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final String? previousSearchString;
  final ApiPageDetails? previousPageDetails;
  const LanguageCreationPage(
      {this.previousSearchString, this.previousPageDetails, Key? key})
      : super(key: key);

  void create(
      ValueNotifier<GlobalKey<FormState>> formKey,
      WidgetRef ref,
      ValueNotifier<String> error,
      ValueNotifier<Map<String, String>> formValues) async {
    error.value = "";
    if (!(formKey.value.currentState?.validate() ?? false)) return;
    try {
      // Create
      LanguageDomainObject newLanguage = LanguageDomainObject(
          name: formValues.value["name"]!,
          description: formValues.value["description"]);
      await ref
          .read(languageControlProvider(
                  previousSearchString ?? newLanguage.name,
                  previousPageDetails ?? ApiPageDetails())
              .notifier)
          .create(newLanguage);

      router().pop();
    } on ApiError catch (e, stackTrace) {
      String message = e.generateCompiledErrorMessages();
      error.value =
          message.isNotEmpty ? message : e.message ?? "Something went wrong";
    } catch (e, stackTrace) {
      error.value = "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final error = useState("");
    final formValues = useState(<String, String>{});
    return Material(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
              child: Form(
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        validator: ValidationBuilder(
                                requiredMessage: "Name is required")
                            .build(),
                        onChanged: FormHelper.generateFormValueEditor(
                            "name", formValues),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 24),
                        decoration: const InputDecoration(
                            hintText: "Enter language name",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.5))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(bottom: 20, top: 50),
                      child: Text(
                        "Description (optional)",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        minLines: 8,
                        maxLines: 100,
                        maxLength: 8000,
                        onChanged: FormHelper.generateFormValueEditor(
                            "description", formValues),
                        decoration: InputDecoration(
                            hintText: "Enter description",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
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
                  ],
                )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                    child: TextButton(
                        onPressed: () =>
                            create(formKey, ref, error, formValues),
                        child: Text(
                          "Create",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        )))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
