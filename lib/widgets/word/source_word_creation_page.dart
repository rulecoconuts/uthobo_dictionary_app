import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/form/form_helper.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
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

class SourceWordCreationPage extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final String? searchString;
  final Function(FullWordPart) onSubmit;
  const SourceWordCreationPage(
      {Key? key, required this.onSubmit, this.searchString})
      : super(key: key);

  void goToPartOfSpeechCreation(
      ValueNotifier<WordCreationRequest> creationRequest) async {
    router().push("/part_of_speech_selection", extra: <String, dynamic>{
      "on_selection_submitted": (PartOfSpeechDomainObject newPart) {
        router().pop();
        addPartOfSpeech(newPart, creationRequest);
      },
      "on_cancel": () {
        router().pop();
      }
    });
  }

  String validate(WordCreationRequest wordCreationRequest) {
    List<String> errors = [];
    if (wordCreationRequest.name.isEmpty) errors.add("Name cannot be blank");
    if (wordCreationRequest.parts.isEmpty) {
      errors.add("At least one part of speech is required");
    }
    return errors.join("\n");
  }

  /// Create word
  void create(WordCreationRequest wordCreationRequest,
      ValueNotifier<String> error, WidgetRef ref) async {
    // validate creation request
    String validationResult = validate(wordCreationRequest);

    if (validationResult.isNotEmpty) {
      error.value = validationResult;
      return;
    }

    try {
      // Create word
      var wordCreationResult = await (ref
          .read(fullWordControlProvider(searchString ?? "%%",
                  wordCreationRequest.translationContext.source,
                  pageDetails:
                      const ApiPageDetails(sortFields: [ApiSort(name: "name")]))
              .notifier)
          .createWord(wordCreationRequest));

      // Alert listeners
      onSubmit.call(wordCreationResult.word);
    } on ApiError catch (e, stackTrace) {
      String message = e.generateCompiledErrorMessages();
      error.value =
          message.isNotEmpty ? message : e.message ?? "Something went wrong";
    } catch (e, stackTrace) {
      error.value = "Something went wrong";
    }
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
    var creationRequest = useState(WordCreationRequest(
        translationContext: translationContext.value!, parts: []));

    var error = useState("");

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
                      .headlineMedium
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
                  onChanged: (name) => creationRequest.value.name = name,
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
                                      creationRequest: creationRequest.value,
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
                          // SHOW ERROR LABEL IF IT IS NOT EMPTY
                          if (error.value.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 30),
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
                      ))),
              Row(children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(top: 20, bottom: 40),
                      child: RoundedRectangleTextButton(
                        text: "Create",
                        onPressed: () =>
                            create(creationRequest.value, error, ref),
                      )),
                )
              ])
            ],
          ),
        )
      ],
    ));
  }
}
