import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/services/word/word_creation_request_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/go_back_panel.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_play_button.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_record_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PronunciationCreationPage extends HookConsumerWidget {
  final WordCreationRequest wordCreationRequest;
  final PartOfSpeechDomainObject part;
  final Function(PronunciationCreationRequest request) onSubmit;
  final void Function() onCancel;
  const PronunciationCreationPage(
      {required this.onSubmit,
      required this.wordCreationRequest,
      required this.part,
      required this.onCancel,
      Key? key})
      : super(key: key);

  void startRecording(
    ValueNotifier<RecorderController> recorderController,
  ) async {
    // Start recording
    recorderController.value.record();
    // recorderController.notifyListeners();
  }

  void stopRecording(
      ValueNotifier<RecorderController> recorderController,
      ValueNotifier<PronunciationCreationRequest>
          pronunciationCreationRequest) async {
    pronunciationCreationRequest.value.audioUrl =
        await recorderController.value.stop() ?? "";
    pronunciationCreationRequest.value.audioMillisecondDuration =
        recorderController.value.recordedDuration.inMilliseconds;
    // pronunciationCreationRequest.notifyListeners();
  }

  void startPlayer(ValueNotifier<PlayerController> playerController,
      ValueNotifier<PlayerState> playerState) async {
    try {
      print("start");

      await playerController.value.startPlayer();
      playerState.value = PlayerState.playing;
    } catch (e) {
      print(e);
    }
  }

  void stopPlayer(ValueNotifier<PlayerController> playerController,
      ValueNotifier<PlayerState> playerState) async {
    try {
      print("stop");
      await playerController.value.stopPlayer();
      playerState.value = PlayerState.stopped;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pronunciationCreationRequest =
        useState(PronunciationCreationRequest(audioUrl: ""));
    var recorderController = useState(RecorderController());
    var playerController = useState(PlayerController());
    var recorderState = useState(recorderController.value.recorderState);
    var playerState = useState(playerController.value.playerState);

    useEffect(() {
      if (pronunciationCreationRequest.value.audioUrl.isEmpty) return;

      playerController.value.preparePlayer(
          path: pronunciationCreationRequest.value.audioUrl, noOfSamples: 400);
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

    // useEffect(() {
    //   var refreshOnPlayerStateChanged = () {
    //     if (playerState.value != playerController.value.playerState) {
    //       playerState.value = playerController.value.playerState;
    //     }
    //   };

    //   playerController.value.addListener(refreshOnPlayerStateChanged);

    //   return () =>
    //       playerController.value.removeListener(refreshOnPlayerStateChanged);
    // }, [playerController.value]);

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
              Padding(
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
                                  "Add pronunciation of ${wordCreationRequest.name}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
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
                                  fontSize: 20, fontWeight: FontWeight.w500),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: PronunciationRecordButton(
                          isRecording: recorderController.value.isRecording,
                          onStartRequested: () =>
                              startRecording(recorderController),
                          onStopRequested: () => stopRecording(
                              recorderController, pronunciationCreationRequest),
                        ),
                      ),
                      if (recorderController.value.isRecording)
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: AudioWaveforms(
                            size: Size(
                                MediaQuery.of(context).size.width - 20, 71),
                            recorderController: recorderController.value,
                            waveStyle: WaveStyle(
                                extendWaveform: true, showMiddleLine: false),
                          ),
                        )
                      else if (pronunciationCreationRequest
                          .value.audioUrl.isNotEmpty)
                        Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: PronunciationPlayButton(
                                        onPlay: () => startPlayer(
                                            playerController, playerState),
                                        isPlaying: playerState.value.isPlaying,
                                        onStop: () => stopPlayer(
                                            playerController, playerState)),
                                  ),
                                  Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: AudioFileWaveforms(
                                        size: Size(
                                            MediaQuery.of(context).size.width -
                                                100,
                                            71),
                                        enableSeekGesture: true,
                                        playerController:
                                            playerController.value,
                                        waveformType: WaveformType.long,
                                        playerWaveStyle: PlayerWaveStyle(
                                            showSeekLine: false,
                                            fixedWaveColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            liveWaveColor: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ))
                                ],
                              )),
                        )
                    ],
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
