import 'package:dictionary_app/services/list/list_separator_extension.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/pronunciation/providers/pronunciation_upload_stream_provider.dart';
import 'package:dictionary_app/services/pronunciation/upload_stage.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:dictionary_app/widgets/word/pronunciation_upload_status_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordPartPronunciationUploadListView extends HookConsumerWidget {
  final WordPartDomainObject wordPart;
  final Function(PronunciationDomainObject newPronunciation)?
      onPronunciationAdded;
  const WordPartPronunciationUploadListView(
      {required this.wordPart, this.onPronunciationAdded, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ongoingUploads = useState(<PronunciationPresignResult>{});
    var statusStream = ref.watch(pronunciationUploadStreamProvider(wordPart));
    var lastStatus = useState<PronunciationUploadStatus?>(null);

    if (statusStream.hasValue &&
        statusStream.value!.stage == UploadStage.successful &&
        lastStatus.value != statusStream.value) {
      // Remove successful uploads
      ongoingUploads.value
          .remove(statusStream.value!.pronunciationPresignResult);
      lastStatus.value = statusStream.value;

      // Notify a listener by callback
      onPronunciationAdded
          ?.call(statusStream.value!.pronunciationPresignResult.pronunciation);
    } else if (statusStream.hasValue &&
        statusStream.value!.stage == UploadStage.failed) {
      // Remove failed uploads
      ongoingUploads.value
          .remove(statusStream.value!.pronunciationPresignResult);
      lastStatus.value = statusStream.value;
    } else if (statusStream.hasValue &&
        !ongoingUploads.value
            .contains(statusStream.value!.pronunciationPresignResult)) {
      // Add upload to list if it is not completed and it has not been encountered before
      ongoingUploads.value.add(statusStream.value!.pronunciationPresignResult);
      lastStatus.value = statusStream.value;
    }

    return Column(
      children: ongoingUploads.value
          .map((e) => PronunciationUploadStatusDisplay(presignResult: e))
          .toList()
          .cast<Widget>()
          .separator(() => const Padding(padding: EdgeInsets.only(top: 10)))
          .toList(),
    );
  }
}
