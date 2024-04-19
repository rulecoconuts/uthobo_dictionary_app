import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/word/word_part_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartsListFetchView extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final FullWordPart fullWord;
  const WordPartsListFetchView({required this.fullWord, super.key});

  void addPartOfSpeech(PartOfSpeechDomainObject newPart,
      ValueNotifier<FullWordPart> wordNotif) {}

  void goToPartOfSpeechCreation(ValueNotifier<FullWordPart> wordNotif) async {
    router().push("/part_of_speech_selection", extra: <String, dynamic>{
      "on_selection_submitted": (PartOfSpeechDomainObject newPart) {
        router().pop();
        addPartOfSpeech(newPart, wordNotif);
      },
      "on_cancel": () {
        router().pop();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var wordNotif = useState(fullWord);

    return Column(
      children: [
        // TODD: Display Parts
        ...wordNotif.value.parts.map((pair) => WordPartView(
              partWordPair: pair,
              word: wordNotif.value.word,
            )),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: RoundedRectangleTextTagAddButton(
            text: "Add part",
            onClicked: () {
              goToPartOfSpeechCreation(wordNotif);
            },
          ),
        ),
      ],
    );
  }
}
