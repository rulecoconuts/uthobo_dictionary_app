import 'package:flutter/material.dart';

class PronunciationPlayButton extends StatelessWidget {
  final double size;
  final bool isPlaying;
  final void Function() onPlay;
  final void Function() onStop;
  const PronunciationPlayButton(
      {this.size = 100,
      required this.onPlay,
      required this.isPlaying,
      required this.onStop,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          (isPlaying ? onStop : onPlay).call();
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.primary)),
          child: Icon(
            isPlaying ? Icons.pause_outlined : Icons.play_arrow_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ));
  }
}
