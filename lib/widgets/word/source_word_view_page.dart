import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/text/editable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourceWordViewPage extends HookConsumerWidget with RoutingUtilsAccessor {
  final FullWordPart fullWord;
  const SourceWordViewPage({required this.fullWord, super.key});

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

  void addPartOfSpeech(PartOfSpeechDomainObject newPart,
      ValueNotifier<FullWordPart> wordNotif) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translationContext = ref.watch(translationContextControlProvider);
    final name = fullWord.word.name;
    var wordNotif = useState(fullWord);

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

              // TODO: REPLACE WITH EDITABLE TEXT VIEW
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: EditableTextView(
                      initial: wordNotif.value.word.name,
                      onEdit: (newName) async {
                        // TODO: Save new name
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.center,
                      validator:
                          ValidationBuilder(requiredMessage: "Name is required")
                              .build(),
                      textBoxStyle: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                      inputDecoration: const InputDecoration(
                          hintText: "Write the word here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 0.5))))),
              // Padding(
              //   padding: EdgeInsets.only(top: 50),
              //   child: TextFormField(
              //     textCapitalization: TextCapitalization.sentences,
              //     validator:
              //         ValidationBuilder(requiredMessage: "Name is required")
              //             .build(),
              //     onChanged: (name) => creationRequest.value.name = name,
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineLarge
              //         ?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
              //     decoration: const InputDecoration(
              //         hintText: "Write the word here",
              //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
              //         border: UnderlineInputBorder(
              //             borderSide: BorderSide(width: 0.5))),
              //   ),
              // ),
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
                          // TODO: DISPLAY PARTS
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: RoundedRectangleTextTagAddButton(
                              text: "Add part",
                              onClicked: () {
                                goToPartOfSpeechCreation(wordNotif);
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
            ],
          ),
        )
      ],
    ));
  }
}
