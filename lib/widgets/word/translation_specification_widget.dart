import 'package:dictionary_app/services/word/word_creation_translation_specification.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_card.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TranslationSpecificationWidget extends HookWidget {
  final WordCreationTranslationSpecification translation;
  const TranslationSpecificationWidget({required this.translation, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          RoundedRectangleTextTag(
            text: translation.word?.word.name ?? "",
            filled: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          )
        ]),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 7200,
            initialValue: translation.note,
            onChanged: (val) => translation.note = val,
            decoration: InputDecoration(
                hintText: "Enter translation note",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
