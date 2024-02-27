import 'package:flutter/material.dart';

class RoundedRectangleTextButton extends StatelessWidget {
  final bool enabled;
  final void Function() onPressed;
  final String text;
  const RoundedRectangleTextButton(
      {required this.text,
      this.enabled = true,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
            backgroundColor:
                enabled ? null : MaterialStateProperty.all(Colors.grey)),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ));
  }
}
