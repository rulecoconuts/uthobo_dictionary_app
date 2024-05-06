import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/part_word_part_pair.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
import 'package:dictionary_app/services/word/vowel_checker.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/word/word_part_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartsListFetchView extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final FullWordPart fullWord;
  const WordPartsListFetchView({required this.fullWord, super.key});

  Future addPartOfSpeech(PartOfSpeechDomainObject newPart,
      ValueNotifier<FullWordPart> wordNotif, WidgetRef ref) async {
    // Make sure part does not already exist for word
    if (wordNotif.value.containsPart(newPart)) {
      ToastShower().showToast(
          "${wordNotif.value.word.name} is already ${VowelChecker().addIndefiniteArticle(newPart.name)}");
      return;
    }
    WordPartDomainObject model =
        WordPartDomainObject(wordId: fullWord.word.id!, partId: newPart.id!);
    WordPartDomainObject createdWordPart = await ref
        .read(fullWordControlProvider("%%",
                LanguageDomainObject(name: "", id: fullWord.word.languageId))
            .notifier)
        .createWordPart(model);

    PartWordPartPair pair =
        PartWordPartPair(wordPart: createdWordPart, part: newPart);

    wordNotif.value.parts.add(pair);
    wordNotif.notifyListeners();
    // ToastShower().showToast("Created part");
  }

  void goToPartOfSpeechCreation(
      ValueNotifier<FullWordPart> wordNotif, WidgetRef ref) async {
    router().push("/part_of_speech_selection", extra: <String, dynamic>{
      "on_selection_submitted": (PartOfSpeechDomainObject newPart) {
        router().pop();
        addPartOfSpeech(newPart, wordNotif, ref);
      },
      "on_cancel": () {
        router().pop();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var wordNotif = useState(fullWord);
    bool shouldshowWordPartDeleteButton = wordNotif.value.parts.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODD: Display Parts
        ...wordNotif.value.parts
            .map((pair) => WordPartView(
                  partWordPair: pair,
                  word: wordNotif.value.word,
                  showDeleteButton: shouldshowWordPartDeleteButton,
                  onDelete: (pair) {
                    // Word part has been deleted. Update state to reflect that/
                    wordNotif.value.parts.remove(pair);
                    wordNotif.notifyListeners();
                  },
                ))
            .cast<Widget>()
            .separator(() => const Padding(padding: EdgeInsets.only(top: 25))),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: RoundedRectangleTextTagAddButton(
            text: "Add part",
            onClicked: () {
              goToPartOfSpeechCreation(wordNotif, ref);
            },
          ),
        ),
      ],
    );
  }
}
