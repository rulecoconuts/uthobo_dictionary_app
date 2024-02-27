import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RoundedRectangleTextTagAddButton extends HookWidget {
  final bool filled;
  final EdgeInsets padding;
  final String text;
  final Function() onClicked;

  const RoundedRectangleTextTagAddButton(
      {required this.text,
      required this.onClicked,
      this.filled = false,
      this.padding = const EdgeInsets.all(8),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 25;
    return InkWell(
      onTap: onClicked,
      child: RoundedRectangleTag(
        filled: filled,
        padding: padding,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: (80 * size) / 100,
              )),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: filled
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary)))
        ]),
      ),
    );
  }
}
