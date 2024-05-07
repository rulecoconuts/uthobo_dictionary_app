import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WordPreview extends HookWidget {
  final FullWordPart fullWord;
  final Function(FullWordPart fullWord) onDeleteRequested;
  final Function(FullWordPart fullWord) onClick;
  const WordPreview(
      {required this.fullWord,
      required this.onDeleteRequested,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedRectangleCard(
        child: Row(
      children: [
        Expanded(
            child: InkWell(
                onTap: () => onClick(fullWord),
                child: Text(
                  fullWord.word.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                ))),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () => onDeleteRequested(fullWord),
            child: Icon(
              MdiIcons.delete,
              color: Colors.red,
            ),
          ),
        )
      ],
    ));
  }
}
