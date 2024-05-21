import 'package:flutter/material.dart';

class RoundedRectangleTextButton extends StatelessWidget {
  final bool enabled;
  final void Function() onPressed;
  final String text;
  final bool filled;
  const RoundedRectangleTextButton(
      {required this.text,
      this.enabled = true,
      this.filled = true,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color>? backgroundColor;
    Color? textColor;
    MaterialStateProperty<BorderSide>? borderSide;

    if (enabled) {
      backgroundColor = filled ? null : MaterialStateProperty.all(Colors.white);
      textColor = filled ? Colors.white : null;
      borderSide = filled
          ? null
          : MaterialStateProperty.all(
              BorderSide(color: Theme.of(context).colorScheme.primary));
    } else {
      backgroundColor = MaterialStateProperty.all(Colors.grey);
      textColor = Colors.grey;
    }
    return TextButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(backgroundColor: backgroundColor, side: borderSide),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
        ));
  }
}
