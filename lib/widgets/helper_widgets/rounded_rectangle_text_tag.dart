import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RoundedRectangleTextTag extends HookWidget {
  final bool filled;
  final EdgeInsets padding;
  final String text;
  final Color? color;

  const RoundedRectangleTextTag(
      {required this.text,
      this.filled = false,
      this.padding = const EdgeInsets.all(8),
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 25;
    return RoundedRectangleTag(
      filled: filled,
      color: color,
      padding: padding,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: filled
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary))
      ]),
    );
  }
}
