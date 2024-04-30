import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_presign_result.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pronunciation_upload_stream_provider.g.dart';

@riverpod
class PronunciationUploadStream extends _$PronunciationUploadStream
    with PronunciationUtilsAccessor {
  @override
  Stream<PronunciationUploadStatus> build(WordPartDomainObject wordPart,
      {PronunciationPresignResult? specificPronunciationToWatch}) async* {
    if (specificPronunciationToWatch == null) {
      yield* (await pronunciationUploadScheduler())
          .listenForWordPart(wordPart.id ?? 0);
    } else {
      yield* (await pronunciationUploadScheduler())
          .listen(specificPronunciationToWatch);
    }
  }

  Future schedule(
      PronunciationCreationRequest pronunciationCreationRequest) async {
    // Presign pronunciation creation request
    var presignResult = await (await pronunciationService())
        .presign(pronunciationCreationRequest);

    // Schedule pronunciation upload and creation to run in the background
    (await pronunciationUploadScheduler()).schedule(presignResult);
  }
}
