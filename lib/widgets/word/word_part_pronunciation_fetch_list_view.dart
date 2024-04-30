import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/providers/pronunciation_list_future_provider.dart';
import 'package:dictionary_app/services/pronunciation/providers/pronunciation_upload_stream_provider.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/part_word_part_pair.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_icon_button.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartPronunciationFetchListView extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final PartWordPartPair partWordPair;
  final WordDomainObject word;

  const WordPartPronunciationFetchListView(
      {required this.partWordPair, required this.word, super.key});

  void goToPronunciationCreationPage(WidgetRef ref) {
    router().push(Constants.pronunciationCreationRoutePath,
        extra: <String, dynamic>{
          "word_name": word.name,
          "part": partWordPair.part,
          "initial_pronunciation_request": null,
          "on_submit": (pronunciationCreationRequest) {
            router().pop();
            schedulePronunciationCreation(pronunciationCreationRequest, ref);
          }
        });
  }

  void schedulePronunciationCreation(
      PronunciationCreationRequest pronunciationCreationRequest,
      WidgetRef ref) {
    pronunciationCreationRequest.wordPartId =
        partWordPair.wordPart.id; // Word Part ID is already known
    ref
        .read(pronunciationUploadStreamProvider(partWordPair.wordPart).notifier)
        .schedule(pronunciationCreationRequest);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listState =
        ref.watch(pronunciationListFutureProvider(partWordPair.wordPart));

    var pronunciations = useState(<PronunciationDomainObject>{});
    var hasFetchedInitial = useState(false);

    if (listState.hasValue && !hasFetchedInitial.value) {
      pronunciations.value.addAll(listState.value!);
      hasFetchedInitial.value = true;
    }

    List<Widget> pronunciationWidgets = pronunciations.value
        .map((e) => PronunciationDisplayWidget(
            pronunciation: e,
            onInfoClicked: (pronunciation) {},
            onDeleteClicked: (pronunciation) {}))
        .cast<Widget>()
        .separator(() => const Padding(padding: EdgeInsets.only(top: 10)))
        .toList();

    return Column(
      children: [
        ...pronunciationWidgets,
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(children: [
            RoundedRectangleTextTagIconButton(
                icon: Icons.mic,
                text: "Add pronunciation",
                onClicked: () => goToPronunciationCreationPage(ref))
          ]),
        )
      ],
    );
  }
}
