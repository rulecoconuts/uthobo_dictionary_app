import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/providers/full_word_control.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/text/editable_text_view.dart';
import 'package:dictionary_app/widgets/word/word_parts_list_fetch_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourceWordViewPage extends HookConsumerWidget with RoutingUtilsAccessor {
  final FullWordPart fullWord;
  final Function()? onCancel;
  const SourceWordViewPage({required this.fullWord, this.onCancel, super.key});

  Future<String?> updateWord(WordDomainObject word, WidgetRef ref) async {
    try {
      String searchName = fullWord.word.name;
      LanguageDomainObject language =
          LanguageDomainObject(name: "", id: fullWord.word.languageId);
      WordDomainObject createdWord = await ref
          .read(fullWordControlProvider(searchName, language).notifier)
          .updateWordDomainObject(word);

      return null;
    } on ApiError catch (e, stackTrace) {
      return e.generateCompiledErrorMessages();
    } catch (e, stackTrace) {
      return "$e";
    }
  }

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
                child: GoBackPanel(
                  onTap: onCancel,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: EditableTextView(
                      initial: wordNotif.value.word.name,
                      onEdit: (newName) async {
                        // Save new name
                        String? error = await updateWord(
                            wordNotif.value.word.copyWith(name: newName), ref);
                        if (error != null) return error;

                        wordNotif.value.word.name = newName;
                        wordNotif.notifyListeners();

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
                          // PARTS
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: WordPartsListFetchView(fullWord: fullWord),
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
