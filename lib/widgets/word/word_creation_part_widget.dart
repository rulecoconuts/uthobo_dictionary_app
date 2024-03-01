import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_icon_button.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_creation_request_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordCreationPartWidget extends HookConsumerWidget
    with RoutingUtilsAccessor, PronunciationUtilsAccessor {
  final WordCreationWordPartSpecification initialWordPartSpecification;
  final WordCreationRequest creationRequest;
  const WordCreationPartWidget(
      {required this.initialWordPartSpecification,
      required this.creationRequest,
      Key? key})
      : super(key: key);

  void goToPronunciationCreationPage(
    ValueNotifier<WordCreationWordPartSpecification>
        wordPartSpecificationNotifier,
    PronunciationCreationRequest? pronunciation,
  ) {
    router().push("/pronunciation_creation", extra: {
      "word_creation_request": creationRequest,
      "part": initialWordPartSpecification.part,
      "initial_pronunciation_request": pronunciation,
      "on_submit": (newPronunciation) {
        router().pop();
        addNewlyCreatedPronunciationToSpecification(newPronunciation,
            wordPartSpecificationNotifier, pronunciation == null);
      },
    });
  }

  void deletePronunciation(
      PronunciationCreationRequest pronunciation,
      ValueNotifier<WordCreationWordPartSpecification>
          wordCreationWordPartSpecification) async {
    wordCreationWordPartSpecification.value.pronunciations
        .remove(pronunciation);
    await pronunciationDeletionService()
        .deletePronunciationCreationRequest(pronunciation);
    wordCreationWordPartSpecification.notifyListeners();
  }

  void addNewlyCreatedPronunciationToSpecification(
      PronunciationCreationRequest creationRequest,
      ValueNotifier<WordCreationWordPartSpecification>
          wordPartSpecificationNotifier,
      bool isNew) {
    if (creationRequest.audioUrl.isEmpty) {
      ToastShower().showToast("No audio pronunciation was recorded");
      if (!isNew) {
        wordPartSpecificationNotifier.value.pronunciations
            .remove(creationRequest);
      }
      return;
    }

    if (isNew) {
      wordPartSpecificationNotifier.value.pronunciations.add(creationRequest);
    }
    wordPartSpecificationNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var wordPartSpecification = useState(initialWordPartSpecification);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: RoundedRectangleTextTag(
            text: wordPartSpecification.value.part.name,
            filled: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Definition textbox
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Definition",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 100,
                    maxLength: 2000,
                    initialValue: wordPartSpecification.value.definition,
                    onChanged: (val) =>
                        wordPartSpecification.value.definition = val,
                    decoration: InputDecoration(
                        hintText: "Enter definition",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                  ),
                ),
              ]),
              if (wordPartSpecification.value.note == null)
                Row(children: [
                  RoundedRectangleTextTagAddButton(
                      text: "Add note",
                      onClicked: () {
                        wordPartSpecification.value.note = "";
                        wordPartSpecification.notifyListeners();
                      })
                ])
              else
                // Note text box
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Note",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 100,
                          maxLength: 7200,
                          initialValue: wordPartSpecification.value.note,
                          onChanged: (val) =>
                              wordPartSpecification.value.note = val,
                          decoration: InputDecoration(
                              hintText: "Enter note",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ]),
              // Existing pronunciation requests
              if (wordPartSpecification.value.pronunciations.isNotEmpty)
                ...wordPartSpecification.value.pronunciations
                    .map((e) => PronunciationCreationRequestDisplay(
                          request: e,
                          onInfoClicked: (pronunciation) =>
                              goToPronunciationCreationPage(
                                  wordPartSpecification, pronunciation),
                          onDeleteClicked: (pronunciation) =>
                              deletePronunciation(
                                  pronunciation, wordPartSpecification),
                        )),
              Row(children: [
                RoundedRectangleTextTagIconButton(
                    icon: Icons.mic,
                    text: "Add pronunciation",
                    onClicked: () => goToPronunciationCreationPage(
                        wordPartSpecification, null))
              ]),
              Row(children: [
                RoundedRectangleTextTagAddButton(
                    text: "Add translation", onClicked: () {})
              ])
            ]
                .separator(() => Padding(padding: EdgeInsets.only(top: 10)))
                .toList(),
          ),
        )
      ],
    );
  }
}
