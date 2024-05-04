import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/translation_context_domain_object.dart';
import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/toast/toast_shower.dart';
import 'package:dictionary_app/services/translation/full_translation.dart';
import 'package:dictionary_app/services/translation/providers/translation_list_future_provider.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/part_word_part_pair.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag_add_button.dart';
import 'package:dictionary_app/widgets/translation/translation_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartTranslationFetchList extends HookConsumerWidget
    with RoutingUtilsAccessor {
  final PartWordPartPair pair;
  final WordDomainObject word;
  final TranslationContextDomainObject translationContext;

  const WordPartTranslationFetchList(
      {required this.pair,
      required this.word,
      required this.translationContext,
      super.key});

  void goToTranslationSelectionPage(
      ValueNotifier<List<FullTranslation>> translations, WidgetRef ref) {
    router()
        .push(Constants.translationSelectionRoutePath, extra: <String, dynamic>{
      "part": pair.part,
      "word": word.name,
      "on_submit": (targetWord) {
        addTranslation(translations, targetWord, ref);
        router().pop();
      },
      "on_cancel": () {
        router().pop();
      }
    });
  }

  Future addTranslation(ValueNotifier<List<FullTranslation>> translations,
      FullWordPart targetWord, WidgetRef ref) async {
    // Check if translation with the target word exists
    var targetWordPart = targetWord.getWordPart(pair.part);
    if (targetWordPart == null) return;
    bool exists =
        translations.value.any((element) => element.contains(targetWordPart));
    if (exists) {
      ToastShower().showToast("Translation already exists");
      return;
    }

    // Create translation to target word part
    TranslationDomainObject requestModel = TranslationDomainObject(
        sourceWordPartId: pair.wordPart.id!,
        targetWordPartId: targetWordPart.id!);
    TranslationDomainObject createdTranslation = await ref
        .read(translationListFutureProvider(
                pair.wordPart, translationContext.target)
            .notifier)
        .createTranslation(requestModel);
    FullTranslation newFullTranslation = FullTranslation(
        translation: createdTranslation,
        sourceWord: word,
        sourceWordPart: pair.wordPart,
        targetWord: targetWord.word,
        targetWordPart: targetWordPart);

    translations.value.add(newFullTranslation);
    translations.notifyListeners();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newState = ref.watch(translationListFutureProvider(
        pair.wordPart, translationContext.target));
    var translations = useState(<FullTranslation>[]);

    if (newState.hasValue) {
      var newList = translations.value.toSet().union(newState.value!.toSet());
      translations.value.clear();
      translations.value.addAll(newList);
    }

    if (translations.value.isEmpty)
      return Text(
        "No translations",
        style: Theme.of(context).textTheme.bodyMedium,
      );

    return Column(
      children: [
        ...translations.value
            .map((e) => TranslationDisplay(
                  translation: e,
                  translationContext: translationContext,
                ))
            .cast<Widget>()
            .toList()
            .separator(() => const Padding(padding: EdgeInsets.only(top: 20))),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(children: [
              RoundedRectangleTextTagAddButton(
                  text: "Add translation",
                  onClicked: () =>
                      goToTranslationSelectionPage(translations, ref))
            ]))
      ],
    );
  }
}
