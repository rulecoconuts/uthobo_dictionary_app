import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';

abstract interface class PronunciationDeletionService {
  Future<bool> deletePronunciationCreationRequest(
      PronunciationCreationRequest pronunciationCreationRequest);
}
