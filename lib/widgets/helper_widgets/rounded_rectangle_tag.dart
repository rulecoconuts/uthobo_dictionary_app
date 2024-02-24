import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RoundedRectangleTag extends HookWidget {
  final bool filled;
  final Widget child;
  final EdgeInsets padding;
  const RoundedRectangleTag(
      {required this.child,
      this.filled = false,
      this.padding = const EdgeInsets.all(5),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: filled ? Theme.of(context).colorScheme.primary : null,
          border: filled
              ? null
              : Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
