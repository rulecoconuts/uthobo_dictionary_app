import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_tag.dart';
import 'package:flutter/material.dart';

class RoundedRectangleTextTagIconButton extends StatelessWidget {
  final bool filled;
  final EdgeInsets padding;
  final String text;
  final Function() onClicked;
  final IconData icon;
  const RoundedRectangleTextTagIconButton(
      {required this.text,
      required this.icon,
      required this.onClicked,
      this.filled = false,
      this.padding = const EdgeInsets.all(8),
      super.key});

  @override
  Widget build(BuildContext context) {
    double size = 25;
    Color mainColor = Theme.of(context).colorScheme.primary;
    return InkWell(
      onTap: onClicked,
      child: RoundedRectangleTag(
        filled: filled,
        padding: padding,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            icon,
            color: filled ? Colors.white : mainColor,
            size: size,
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: filled ? Colors.white : mainColor)))
        ]),
      ),
    );
  }
}
