import 'dart:math';

import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/vowel_checker.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TranslationOptionWidget extends HookWidget {
  final FullWordPart wordPart;
  final bool isSelected;
  final PartOfSpeechDomainObject desiredPart;
  final Function(bool containsPart) onClicked;
  const TranslationOptionWidget(
      {required this.wordPart,
      required this.desiredPart,
      required this.onClicked,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool containsPart = wordPart.containsPart(desiredPart);

    return InkWell(
        onTap: () => onClicked(containsPart),
        child: RoundedRectangleCard(
          filled: isSelected,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                wordPart.word.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: isSelected ? Colors.white : Colors.black),
              ),
              if (!containsPart)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Click to mark as ${VowelChecker().addIndefiniteArticle(desiredPart.name)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black54),
                  ),
                )
            ],
          ),
        ));
  }
}
