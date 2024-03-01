import 'dart:io';

import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_deletion_service.dart';

class SimplePronunciationDeletionService
    implements PronunciationDeletionService {
  @override
  Future<bool> deletePronunciationCreationRequest(
      PronunciationCreationRequest pronunciationCreationRequest) async {
    String audioUrl = pronunciationCreationRequest.audioUrl;
    if (audioUrl.isEmpty) return false;

    pronunciationCreationRequest.audioUrl = "";
    pronunciationCreationRequest.audioByteSize = null;
    pronunciationCreationRequest.audioFileType = null;
    pronunciationCreationRequest.audioMillisecondDuration = null;
    try {
      File(audioUrl).deleteSync();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
