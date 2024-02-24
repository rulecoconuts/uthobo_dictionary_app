import 'package:dictionary_app/services/form/form_helper.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordCreationPage extends HookConsumerWidget {
  final String? searchString;
  const WordCreationPage({Key? key, this.searchString}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translationContext = ref.watch(translationContextControlProvider);
    var formValues = useState(<String, String>{});

    if (translationContext.isLoading) return Container();

    if (!translationContext.hasValue) return Container();

    return Material(
        child: CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 60),
                child: Text(
                  "Create word in ${translationContext.value?.source.name}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  validator:
                      ValidationBuilder(requiredMessage: "Name is required")
                          .build(),
                  onChanged:
                      FormHelper.generateFormValueEditor("name", formValues),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                  decoration: const InputDecoration(
                      hintText: "Write the word here",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 0.5))),
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10).copyWith(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(
                          "Parts of Speech",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: RoundedRectangleTextTagAddButton(
                          text: "Add part",
                          onClicked: () {},
                        ),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
