import 'package:flutter/material.dart';

class RoundedRectangleCard extends StatelessWidget {
  final Widget child;
  final bool filled;
  const RoundedRectangleCard(
      {required this.child, this.filled = false, super.key});

  @override
  Widget build(BuildContext context) {
    double radius = 8;
    return Container(
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(radius)),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: filled ? Colors.transparent : Colors.white,
            border: filled ? null : Border.all(),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius),
                bottomRight: Radius.circular(radius))),
        child: child,
      ),
    );
  }
}
