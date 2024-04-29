import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/providers/pronunciation_list_future_provider.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartPronunciationFetchListView extends HookConsumerWidget {
  final WordPartDomainObject wordPart;
  final WordDomainObject word;

  const WordPartPronunciationFetchListView(
      {required this.wordPart, required this.word, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: IMPLEMENT
    var listState = ref.watch(pronunciationListFutureProvider(wordPart));

    var pronunciations = useState(<PronunciationDomainObject>{});
    var hasFetchedInitial = useState(false);

    if (listState.hasValue && !hasFetchedInitial.value) {
      pronunciations.value.addAll(listState.value!);
      hasFetchedInitial.value = true;
    }

    // return Container(
    //   color: Colors.red,
    //   height: 100,
    // );

    List<Widget> children = pronunciations.value
        .map((e) => PronunciationDisplayWidget(
            pronunciation: e,
            onInfoClicked: (pronunciation) {},
            onDeleteClicked: (pronunciation) {}))
        .cast<Widget>()
        .separator(() => const Padding(padding: EdgeInsets.only(top: 10)))
        .toList();

    return Column(
      children: children,
    );
  }
}
