import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final void Function()? onTap;
  final double size;
  final Color? backgroundColor;
  final IconData icon;
  final Color? iconColor;
  const CircularIconButton(
      {required this.icon,
      this.onTap,
      this.size = 60,
      this.backgroundColor,
      this.iconColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor ?? Theme.of(context).colorScheme.primary),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: (80 * size) / 100,
          ),
        ));
  }
}
