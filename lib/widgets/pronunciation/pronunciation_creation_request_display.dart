import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dictionary_app/services/pronunciation/pronunciation_creation_request.dart';
import 'package:dictionary_app/widgets/helper_widgets/circular_icon_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_tag.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_play_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PronunciationCreationRequestDisplay extends HookConsumerWidget {
  final PronunciationCreationRequest request;
  final Function(PronunciationCreationRequest request) onInfoClicked;
  final Function(PronunciationCreationRequest request) onDeleteClicked;
  final double? size;
  const PronunciationCreationRequestDisplay(
      {required this.request,
      required this.onInfoClicked,
      required this.onDeleteClicked,
      this.size,
      Key? key})
      : super(key: key);

  Future play(ValueNotifier<PlayerController> playerController) async {
    await playerController.value.startPlayer(finishMode: FinishMode.pause);
  }

  Future stop(ValueNotifier<PlayerController> playerController) async {
    if (request.audioUrl.isEmpty) return;
    await playerController.value.pausePlayer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var playerController = useState(PlayerController());
    var playerState = useState(playerController.value.playerState);

    useEffect(() {
      playerController.value
          .preparePlayer(path: request.audioUrl, noOfSamples: 400);
    }, [playerController.value]);

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

    Size windowSize = MediaQuery.of(context).size;

    double waveFormWidth = windowSize.width * 0.4;

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      RoundedRectangleTag(
          filled: true,
          child: Row(
            children: [
              PronunciationPlayButton(
                  filled: true,
                  color: Colors.white,
                  size: 40,
                  onPlay: () => play(playerController),
                  isPlaying: playerState.value.isPlaying,
                  onStop: () => stop(playerController)),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: AudioFileWaveforms(
                      size: Size(waveFormWidth, 40),
                      playerController: playerController.value,
                      enableSeekGesture: false,
                      waveformType: WaveformType.long,
                      playerWaveStyle: PlayerWaveStyle(
                          showSeekLine: false,
                          waveThickness: 2.5,
                          fixedWaveColor: Colors.white,
                          liveWaveColor: Colors.white)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircularIconButton(
                    icon: Icons.info_outlined,
                    backgroundColor: Colors.white,
                    iconColor: Colors.black,
                    size: 35,
                    onTap: () => onInfoClicked(request),
                  ))
            ],
          )),
      Padding(
          padding: EdgeInsets.only(left: 15),
          child: CircularIconButton(
            icon: Icons.close,
            backgroundColor: Colors.red,
            size: 35,
            onTap: () async {
              await stop(playerController);
              onDeleteClicked(request);
            },
          ))
    ]);
  }
}
