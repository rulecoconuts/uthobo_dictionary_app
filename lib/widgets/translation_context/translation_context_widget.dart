import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/widgets/language/language_selection_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TranslationContextWidget extends HookConsumerWidget {
  const TranslationContextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translationContext = ref.watch(translationContextControlProvider);

    var textboxBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(width: 1));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (translationContext.hasValue)
          LanguageSelectionDropdown(
            initialLanguage: translationContext.value?.source,
            onSelectionChanged: (source) {
              ref
                  .read(translationContextControlProvider.notifier)
                  .setWith(source: source);
            },
            border: textboxBorder,
          ),
        Center(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: InkWell(
            onTap: () =>
                ref.read(translationContextControlProvider.notifier).swap(),
            child: const Icon(
              Icons.sync,
              size: 48,
            ),
          ),
        )),
        if (translationContext.hasValue)
          LanguageSelectionDropdown(
            initialLanguage: translationContext.value?.target,
            onSelectionChanged: (target) {
              ref
                  .read(translationContextControlProvider.notifier)
                  .setWith(target: target);
            },
            border: textboxBorder,
          ),
      ],
    );
  }
}
