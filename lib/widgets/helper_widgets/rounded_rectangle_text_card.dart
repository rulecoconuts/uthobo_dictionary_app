import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_card.dart';
import 'package:flutter/material.dart';

class RoundedRectangleTextCard extends StatelessWidget {
  final String text;
  final bool filled;
  const RoundedRectangleTextCard(
      {required this.text, this.filled = false, super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedRectangleCard(
        filled: filled,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: filled ? Colors.white : null,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ));
  }
}
