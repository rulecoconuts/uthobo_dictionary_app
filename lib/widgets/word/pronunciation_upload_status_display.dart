import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/pronunciation/providers/pronunciation_upload_stream_provider.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PronunciationUploadStatusDisplay extends HookConsumerWidget {
  final PronunciationPresignResult presignResult;

  const PronunciationUploadStatusDisplay(
      {required this.presignResult, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var statusUpdate = ref.watch(
      pronunciationUploadStreamProvider(
          WordPartDomainObject(
              id: presignResult.pronunciation.wordPartId, wordId: 0, partId: 0),
          specificPronunciationToWatch: presignResult),
    );

    // TODO: Implement

    return const SizedBox();
  }
}
