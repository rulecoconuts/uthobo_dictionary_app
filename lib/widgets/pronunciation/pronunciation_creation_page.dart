import 'dart:io';
import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dictionary_app/accessors/pronunciation_utils_accessor.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/circular_icon_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_button.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_play_button.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_record_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class PronunciationCreationPage extends HookConsumerWidget
    with PronunciationUtilsAccessor {
  final String wordName;
  final PartOfSpeechDomainObject part;
  final Function(PronunciationCreationRequest request) onSubmit;
  final void Function()? onCancel;
  final PronunciationCreationRequest? initialPronunciationRequest;
  const PronunciationCreationPage(
      {required this.onSubmit,
      required this.wordName,
      required this.part,
      this.onCancel,
      this.initialPronunciationRequest,
      Key? key})
      : super(key: key);

  Future<String> generateRecordingFilePath() async {
    var now = DateTime.now();
    var dir = await getApplicationDocumentsDirectory();

    return "${dir.path}/${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}-${now.millisecond}.m4a";
  }

  void startRecording(
      ValueNotifier<RecorderController> recorderController,
      ValueNotifier<PronunciationCreationRequest> pronunciationCreationRequest,
      ValueNotifier<PlayerController> playerController) async {
    await deleteRecording(pronunciationCreationRequest, playerController);

    // Test ability to create file

    // Start recording
    recorderController.value.record(path: await generateRecordingFilePath());
    // recorderController.notifyListeners();
  }

  String generateRandomString(int len) {
    var r = Random.secure();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  /// Stop recording audio
  void stopRecording(
      ValueNotifier<RecorderController> recorderController,
      ValueNotifier<PronunciationCreationRequest> pronunciationCreationRequest,
      ValueNotifier<PlayerController> playerController) async {
    pronunciationCreationRequest.value.audioUrl =
        await recorderController.value.stop() ?? "";
    pronunciationCreationRequest.value.audioMillisecondDuration =
        recorderController.value.recordedDuration.inMilliseconds;
    pronunciationCreationRequest.value.audioFileType =
        recorderController.value.androidOutputFormat.name;

    File audioFile = File(pronunciationCreationRequest.value.audioUrl);
    pronunciationCreationRequest.value.audioByteSize = audioFile.lengthSync();
    int k = 9;
    // await playerController.value.preparePlayer(
    //     path: pronunciationCreationRequest.value.audioUrl, noOfSamples: 400);
    // pronunciationCreationRequest.notifyListeners();
  }

  void startPlayer(ValueNotifier<PlayerController> playerController,
      ValueNotifier<PlayerState> playerState) async {
    try {
      print("start");

      await playerController.value.startPlayer(
        finishMode: FinishMode.pause,
      );
      playerState.value = PlayerState.playing;
    } catch (e) {
      print(e);
    }
  }

  void stopPlayer(ValueNotifier<PlayerController> playerController,
      ValueNotifier<PlayerState> playerState) async {
    try {
      print("stop");
      await playerController.value.pausePlayer();
      playerState.value = PlayerState.stopped;
    } catch (e) {
      print(e);
    }
  }

  /// Delete audio recording from the file system
  Future deleteRecording(
      ValueNotifier<PronunciationCreationRequest> pronunciationCreationRequest,
      ValueNotifier<PlayerController> playerController) async {
    if (pronunciationCreationRequest.value.audioUrl.isEmpty) return;
    try {
      await playerController.value.pausePlayer();

      await pronunciationDeletionService().deletePronunciationCreationRequest(
          pronunciationCreationRequest.value);
    } catch (e) {
      print(e);
    }

    pronunciationCreationRequest.notifyListeners();
  }

  void submit(PronunciationCreationRequest pronunciationCreationRequest) {
    onSubmit(pronunciationCreationRequest);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pronunciationCreationRequest = useState(initialPronunciationRequest ??
        PronunciationCreationRequest(audioUrl: ""));
    var recorderController = useState(RecorderController());
    var playerController = useState(PlayerController());
    var recorderState = useState(recorderController.value.recorderState);
    var playerState = useState(playerController.value.playerState);

    useEffect(() {
      if (pronunciationCreationRequest.value.audioUrl.isEmpty) return;

      playerController.value.preparePlayer(
          path: pronunciationCreationRequest.value.audioUrl, noOfSamples: 400);
      playerState.value = PlayerState.stopped;
    }, [pronunciationCreationRequest.value.audioUrl]);

    useEffect(() {
      var refreshOnStateChanged = () {
        if (recorderState.value != recorderController.value.recorderState) {
          recorderState.value = recorderController.value.recorderState;
        }
      };

      recorderController.value.addListener(refreshOnStateChanged);

      return () =>
          recorderController.value.removeListener(refreshOnStateChanged);
    }, [recorderController.value]);

    useEffect(() {
      var refreshOnPlayerStateChanged = (PlayerState newPlayerState) {
        if (playerState.value != newPlayerState) {
          playerState.value = newPlayerState;
        }
      };

      // playerController.value.onCompletion.listen((event) { })

      var subscription = playerController.value.onPlayerStateChanged
          .listen(refreshOnPlayerStateChanged);

      return subscription.cancel;
    }, [playerController.value]);

    return Material(
        child: CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: GoBackPanel(),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Text(
                                      "Add pronunciation of ${wordName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              "Spelling",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 100,
                              maxLength: 2000,
                              initialValue: pronunciationCreationRequest
                                  .value.phoneticSpelling,
                              onChanged: (val) => pronunciationCreationRequest
                                  .value.phoneticSpelling = val,
                              decoration: InputDecoration(
                                  hintText: "Enter phonetic spelling",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                            ),
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: PronunciationRecordButton(
                              isRecording: recorderController.value.isRecording,
                              onStartRequested: () => startRecording(
                                  recorderController,
                                  pronunciationCreationRequest,
                                  playerController),
                              onStopRequested: () => stopRecording(
                                  recorderController,
                                  pronunciationCreationRequest,
                                  playerController),
                            ),
                          )),
                          if (recorderController.value.isRecording)
                            // Show recording waveforms
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: AudioWaveforms(
                                size: Size(
                                    MediaQuery.of(context).size.width - 20, 71),
                                recorderController: recorderController.value,
                                waveStyle: WaveStyle(
                                    extendWaveform: true,
                                    showMiddleLine: false),
                              ),
                            )
                          else if (pronunciationCreationRequest
                              .value.audioUrl.isNotEmpty)
                            // Show player control
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: PronunciationPlayButton(
                                              onPlay: () => startPlayer(
                                                  playerController,
                                                  playerState),
                                              isPlaying:
                                                  playerState.value.isPlaying,
                                              onStop: () => stopPlayer(
                                                  playerController,
                                                  playerState)),
                                        ),
                                        Container(
                                            decoration:
                                                BoxDecoration(border: null),
                                            child: AudioFileWaveforms(
                                              size: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  71),
                                              enableSeekGesture: true,
                                              playerController:
                                                  playerController.value,
                                              waveformType: WaveformType.long,
                                              playerWaveStyle: PlayerWaveStyle(
                                                  showSeekLine: false,
                                                  waveThickness: 2.5,
                                                  fixedWaveColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                  liveWaveColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                            ))
                                      ],
                                    ),
                                    Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: CircularIconButton(
                                              icon: Icons.close,
                                              backgroundColor: Colors.red,
                                              size: 40,
                                              onTap: () => deleteRecording(
                                                  pronunciationCreationRequest,
                                                  playerController),
                                            )))
                                  ],
                                )),
                        ],
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(top: 40, bottom: 40),
                child: RoundedRectangleTextButton(
                    text: "Save",
                    onPressed: () =>
                        submit(pronunciationCreationRequest.value)),
              )
            ],
          ),
        )
      ],
    ));
  }
}
