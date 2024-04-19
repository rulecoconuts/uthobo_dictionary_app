import 'package:dictionary_app/services/word/full_word_part.dart';
import 'package:dictionary_app/services/word/word_domain_object.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartPronunciationFetchListView extends HookConsumerWidget {
  final WordPartDomainObject wordPart;
  final WordDomainObject word;

  const WordPartPronunciationFetchListView(
      {required this.wordPart, required this.word, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: IMPLEMENT
    return const SizedBox();
  }
}
