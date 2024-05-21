import 'package:flutter/material.dart';

class PronunciationRecordButton extends StatelessWidget {
  final bool isRecording;
  final void Function() onStartRequested;
  final void Function() onStopRequested;
  const PronunciationRecordButton(
      {this.isRecording = false,
      required this.onStartRequested,
      required this.onStopRequested,
      super.key});

  @override
  Widget build(BuildContext context) {
    double size = 185;
    return InkWell(
        onTap: isRecording ? onStopRequested : onStartRequested,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary),
          child: Icon(
            isRecording ? Icons.stop : Icons.mic,
            size: (60 * size) / 100,
            color: isRecording ? Colors.red : Colors.white,
          ),
        ));
  }
}
