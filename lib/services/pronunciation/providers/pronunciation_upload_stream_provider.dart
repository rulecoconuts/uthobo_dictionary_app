import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_upload_status.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pronunciation_upload_stream_provider.g.dart';

@riverpod
class PronunciationUploadStream extends _$PronunciationUploadStream
    with PronunciationUtilsAccessor {
  @override
  Stream<PronunciationUploadStatus> build(
      WordPartDomainObject wordPart) async* {
    yield* (await pronunciationUploadScheduler())
        .listenForWordPart(wordPart.id ?? 0);
  }
}
