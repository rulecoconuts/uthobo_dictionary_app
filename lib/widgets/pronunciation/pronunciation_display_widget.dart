import 'dart:async';

import 'package:dictionary_app/services/pronunciation/pronunciation_domain_object.dart';
import 'package:dictionary_app/widgets/helper_widgets/circular_icon_button.dart';
import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_tag.dart';
import 'package:dictionary_app/widgets/pronunciation/pronunciation_play_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_audio/just_audio.dart';

class PronunciationDisplayWidget extends HookWidget {
  final PronunciationDomainObject pronunciation;
  final Function(PronunciationDomainObject pronunciation) onInfoClicked;
  final Function(PronunciationDomainObject pronunciation) onDeleteClicked;
  const PronunciationDisplayWidget(
      {required this.pronunciation,
      required this.onInfoClicked,
      required this.onDeleteClicked,
      super.key});

  Future play(ValueNotifier<AudioPlayer> player) async {
    await player.value.play();
  }

  Future pause(ValueNotifier<AudioPlayer> player) async {
    await player.value.pause();
  }

  Future stop(ValueNotifier<AudioPlayer> player) async {
    if (pronunciation.audioUrl.isEmpty) return;
    await player.value.pause();
    player.value.seek(Duration());
  }

  Function() loadData(ValueNotifier<AudioPlayer> player,
      ValueNotifier<double> progress, ValueNotifier<bool> playingNotif) {
    player.value.setUrl(pronunciation.audioUrl);
    player.value.setLoopMode(LoopMode.off);

    var positionSubscription = player.value.positionStream.listen((position) {
      /// Listen for position changes and updates progress fraction
      int total = player.value.duration?.inMilliseconds ??
          pronunciation.audioMillisecondDuration ??
          0;
      if (total == 0) {
        progress.value = 0;
        return;
      }

      progress.value = position.inMilliseconds / total;

      if (progress.value == 1) {
        print("here");
        stop(player);
      }
    });

    var playingSubscription = player.value.playingStream.listen((playing) {
      // Listen to changes in playing state (paused or playing)
      playingNotif.value = playing;
    });
    return () {
      positionSubscription.cancel();
      playingSubscription.cancel();
    };
  }

  @override
  Widget build(BuildContext context) {
    var player = useState(AudioPlayer());

    // var positionStream = useState(player.value.positionStream);
    var progress = useState(0.0);
    var playing = useState(false);

    useEffect(() {
      return loadData(player, progress, playing);
    }, [0]);

    Size windowSize = MediaQuery.of(context).size;

    double waveFormWidth = windowSize.width * 0.4;

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: RoundedRectangleTag(
              filled: true,
              child: Row(
                children: [
                  PronunciationPlayButton(
                      filled: true,
                      color: Colors.white,
                      size: 40,
                      onPlay: () => play(player),
                      isPlaying: playing.value,
                      onStop: () => pause(player)),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      // TODO: ADD AUDIO VISUALIZATION
                      child: LinearProgressIndicator(
                        value: progress.value,
                        color: const Color(0xFF4183F6),
                      ),
                    ),
                  )),
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircularIconButton(
                        icon: Icons.info_outlined,
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                        size: 35,
                        onTap: () => onInfoClicked(pronunciation),
                      ))
                ],
              ))),
      Padding(
          padding: EdgeInsets.only(left: 15),
          child: CircularIconButton(
            icon: Icons.close,
            backgroundColor: Colors.red,
            size: 35,
            onTap: () async {
              await stop(player);
              onDeleteClicked(pronunciation);
            },
          ))
    ]);
  }
}
