import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/form/form_helper.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/word/word_creation_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class WordCreationPage extends HookConsumerWidget with RoutingUtilsAccessor {
  final String? searchString;
  const WordCreationPage({Key? key, this.searchString}) : super(key: key);

  void goToPartOfSpeechCreation(
      ValueNotifier<WordCreationRequest> creationRequest) async {
    router().push("/part_of_speech_selection", extra: <String, dynamic>{
      "on_selection_submitted": (PartOfSpeechDomainObject newPart) =>
          addPartOfSpeech(newPart, creationRequest),
      "on_cancel": () {}
    });
  }

  void addPartOfSpeech(PartOfSpeechDomainObject newPart,
      ValueNotifier<WordCreationRequest> creationRequest) {
    bool alreadyExists =
        creationRequest.value.parts.any((element) => element.part == newPart);

    if (alreadyExists) {
      ToastShower().showToast("Part of speech already exists");
      return;
    }

    creationRequest.value.parts
        .add(WordCreationWordPartSpecification(part: newPart));
    creationRequest.value = creationRequest.value;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translationContext = ref.watch(translationContextControlProvider);
    var formValues = useState(<String, String>{});
    var creationRequest = useState(WordCreationRequest(
        translationContext: translationContext.value!, parts: []));

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
                padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 30),
                child: GoBackPanel(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 30),
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
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(top: 15),
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
                          if (creationRequest.value.parts.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: creationRequest.value.parts
                                  .map((e) => WordCreationPartWidget(
                                      initialWordPartSpecification: e))
                                  .cast<Widget>()
                                  .separator(() => Padding(
                                      padding: EdgeInsets.only(top: 10)))
                                  .toList(),
                            ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: RoundedRectangleTextTagAddButton(
                              text: "Add part",
                              onClicked: () {
                                goToPartOfSpeechCreation(creationRequest);
                              },
                            ),
                          ),
                          Row(children: [
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 40),
                                  child: RoundedRectangleTextButton(
                                    text: "Create",
                                    onPressed: () {},
                                  )),
                            )
                          ])
                        ],
                      )))
            ],
          ),
        )
      ],
    ));
  }
}
