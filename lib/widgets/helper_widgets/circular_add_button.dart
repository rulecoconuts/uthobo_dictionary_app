import 'package:flutter/material.dart';

class CircularAddButton extends StatelessWidget {
  final void Function()? onTap;
  final double size;
  const CircularAddButton({this.onTap, this.size = 100, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: (80 * size) / 100,
          ),
        ));
  }
}
