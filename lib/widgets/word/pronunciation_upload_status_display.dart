import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/pronunciation/providers/pronunciation_upload_stream_provider.dart';
import 'package:dictionary_app/services/pronunciation/upload_stage.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_card.dart';
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

    if (!statusUpdate.hasValue) return const SizedBox.shrink();

    return RoundedRectangleCard(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.mic,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                    child: LinearProgressIndicator(
                  value: statusUpdate.value!.stage == UploadStage.successful
                      ? 1
                      : statusUpdate.value!.progress,
                  borderRadius: BorderRadius.circular(20),
                ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Upload Status: ${statusUpdate.value!.stage.name}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.black54),
              ),
            )
          ],
        ));
  }
}
