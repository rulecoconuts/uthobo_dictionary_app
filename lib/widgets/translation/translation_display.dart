import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/translation/full_translation.dart';
import 'package:dictionary_app/services/translation/providers/translation_list_future_provider.dart';
import 'package:dictionary_app/services/translation/translation_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag.dart';
import 'package:dictionary_app/widgets/text/editable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TranslationDisplay extends HookConsumerWidget {
  final FullTranslation translation;
  final LanguageDomainObject sourceLanguage;
  const TranslationDisplay(
      {required this.translation, required this.sourceLanguage, super.key});

  Future<String?> update(
      TranslationDomainObject translationDomainObject, WidgetRef ref) async {
    try {
      TranslationDomainObject newWordPart = await ref
          .read(translationListFutureProvider(translation.sourceWordPart)
              .notifier)
          .updateTranslation(translationDomainObject);
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
    var updateCount = useState(0);
    return Column(
      children: [
        Row(children: [
          // Target word name
          RoundedRectangleTextTag(
            text: translation.deriveSourceWord(sourceLanguage).name,
            filled: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          )
        ]),

        // Note
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: EditableTextView(
                onEdit: (newNote) async {
                  // Update note
                  var copy = translation.copyWithNote(sourceLanguage, newNote);
                  String? error = await update(translation.translation, ref);

                  if (error != null) return error;

                  translation.setNote(sourceLanguage, newNote);
                  updateCount.value = (updateCount.value + 1) % 5000;
                  return null;
                },
                label: "Note",
                minLines: 2,
                maxLines: 100,
                maxLength: 7200,
                initial: translation.deriveNote(sourceLanguage),
                inputDecoration: InputDecoration(
                    hintText: "Enter translation note",
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w400)))),
      ],
    );
  }
}
