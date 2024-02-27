import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/services/word/word_creation_word_part_specification.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_tag.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordCreationPartWidget extends HookConsumerWidget {
  final WordCreationWordPartSpecification wordPartSpecification;
  const WordCreationPartWidget({required this.wordPartSpecification, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: RoundedRectangleTextTag(
            text: wordPartSpecification.part.name,
            filled: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ],
    );
  }
}
