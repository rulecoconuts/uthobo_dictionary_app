import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_translation_specification.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_icon_button.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_creation_request_display.dart';
import 'package:dictionary_app/widgets/word/translation_specification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Displays a part of speech creation object during the word creation process
class WordCreationPartWidget extends HookConsumerWidget
    with RoutingUtilsAccessor, PronunciationUtilsAccessor {
  final WordCreationWordPartSpecification initialWordPartSpecification;
  final WordCreationRequest creationRequest;
  final bool isSourceWord;
  const WordCreationPartWidget(
      {required this.initialWordPartSpecification,
      required this.creationRequest,
      this.isSourceWord = true,
      Key? key})
      : super(key: key);

  /// Go to pronunciation creation page
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

  /// Go to translation creation page
  void goToTranslationSelectionPage(
      ValueNotifier<WordCreationWordPartSpecification>
          wordCreationWordPartSpecification) {
    router().push("/translation_selection", extra: <String, dynamic>{
      "part": wordCreationWordPartSpecification.value.part,
      "word": creationRequest.name,
      "on_submit": (translation) {
        addTranslation(wordCreationWordPartSpecification, translation);
        router().pop();
      },
      "on_cancel": () {
        router().pop();
      }
    });
  }

  void addTranslation(
      ValueNotifier<WordCreationWordPartSpecification>
          wordCreationWordPartSpecification,
      FullWordPart word) {
    var wordPart =
        word.getWordPart(wordCreationWordPartSpecification.value.part);

    // If word part is null, then word does not have an instance for the desired
    // part of speech. Make sure that any instances for that word are removed
    // from this widget

    if (wordPart == null) {
      var translationForWord = wordCreationWordPartSpecification.value
          .getTranslationByWord(word.word);

      if (translationForWord != null) {
        wordCreationWordPartSpecification.value
            .removeTranslation(translationForWord);
      }

      // Redraw widget
      wordCreationWordPartSpecification.value =
          wordCreationWordPartSpecification.value;
    } else {
      // Word has an instance for desired part of speech.
      var matchingTranslationSpec = wordCreationWordPartSpecification.value
          .getTranslationByWordPart(wordPart);

      if (matchingTranslationSpec == null) {
        // Translation does not exist in word creation spec.
        // Add it
        wordCreationWordPartSpecification.value.addTranslation(
            WordCreationTranslationSpecification(
                wordPart: wordPart, word: word));
      }
      // Redraw widget
      wordCreationWordPartSpecification.value =
          wordCreationWordPartSpecification.value;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var wordPartSpecification = useState(initialWordPartSpecification);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PART NAME DISPLAY
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
              // DEFINITION TEXTBOX
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
              // SHOW ADD NOTE BUTTON IF A NOTE DOES NOT ALREADY EXIST
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
              // EXISTING PRONUNCIATION REQUESTS
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
              if (isSourceWord)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Translations",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ...wordPartSpecification.value.translations.map(
                      (e) => Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child:
                              TranslationSpecificationWidget(translation: e)),
                    ),
                    Row(children: [
                      RoundedRectangleTextTagAddButton(
                          text: "Add translation",
                          onClicked: () => goToTranslationSelectionPage(
                              wordPartSpecification))
                    ])
                  ],
                )
            ]
                .separator(() => Padding(padding: EdgeInsets.only(top: 10)))
                .toList(),
          ),
        )
      ],
    );
  }
}
