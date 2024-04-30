import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/part_word_part_pair.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/text/editable_text_view.dart';
import 'package:dictionary_app/widgets/word/word_part_pronunciation_fetch_list_view.dart';
import 'package:dictionary_app/widgets/word/word_part_translation_fetch_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartView extends HookConsumerWidget {
  final PartWordPartPair partWordPair;
  final WordDomainObject word;
  const WordPartView(
      {required this.partWordPair, required this.word, super.key});

  Future<String?> updateWordPart(
      WordPartDomainObject wordPart, WidgetRef ref) async {
    try {
      WordPartDomainObject newWordPart = await ref
          .read(fullWordControlProvider(
                  "%%", LanguageDomainObject(name: "", id: word.id))
              .notifier)
          .updateWordPart(wordPart);
    } on ApiError catch (e, stackTrace) {
      String error = e.generateCompiledErrorMessages();

      if (error.isEmpty) return e.message ?? e.debugMessage ?? e.status;

      return error;
    } catch (e, stackTracee) {
      return "$e";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pairNotif = useState(partWordPair);

    bool isSourceWord = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PART NAME DISPLAY
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: RoundedRectangleTextTag(
            text: pairNotif.value.part.name,
            filled: true,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  padding: EdgeInsets.zero,
                  child: EditableTextView(
                      label: "Definition",
                      minLines: 2,
                      maxLines: 100,
                      maxLength: 2000,
                      initial: pairNotif.value.wordPart.definition,
                      inputDecoration: InputDecoration(
                          hintText: "Enter definition",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                      onEdit: (newDefinition) async {
                        // Update word part with new definition
                        var error = await updateWordPart(
                            pairNotif.value.wordPart
                                .copyWith(definition: newDefinition),
                            ref);
                        if (error != null) return error;

                        pairNotif.value.wordPart.definition = newDefinition;
                        pairNotif.notifyListeners();
                        return null;
                      }),
                ),
              ]),
              // SHOW ADD NOTE BUTTON IF A NOTE DOES NOT ALREADY EXIST
              if (pairNotif.value.wordPart.note == null)
                Row(children: [
                  RoundedRectangleTextTagAddButton(
                      text: "Add note",
                      onClicked: () {
                        pairNotif.value.wordPart.note = "";
                        pairNotif.notifyListeners();
                      })
                ])
              else
                // Note text box
                Padding(
                    padding: EdgeInsets.zero,
                    child: EditableTextView(
                        minLines: 2,
                        maxLines: 100,
                        maxLength: 7200,
                        initial: pairNotif.value.wordPart.note,
                        label: "Note",
                        inputDecoration: InputDecoration(
                            hintText: "Enter note",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
                        onEdit: (newNote) async {
                          // Update word part with new note
                          var error = await updateWordPart(
                              pairNotif.value.wordPart.copyWith(note: newNote),
                              ref);
                          if (error != null) return error;

                          pairNotif.value.wordPart.definition = newNote;
                          pairNotif.notifyListeners();
                          return null;
                        })),

              // EXISTING PRONUNCIATION REQUESTS
              WordPartPronunciationFetchListView(
                partWordPair: pairNotif.value,
                word: word,
              ),
              if (isSourceWord)
                // WORD PART TRANSLATIONS
                WordPartTranslationFetchList(
                    wordPart: pairNotif.value.wordPart, word: word)
            ]
                .separator(
                    () => const Padding(padding: EdgeInsets.only(top: 10)))
                .toList(),
          ),
        )
      ],
    );
  }
}
