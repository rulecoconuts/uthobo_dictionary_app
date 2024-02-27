import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:flutter/material.dart';

class GoBackPanel extends StatelessWidget with RoutingUtilsAccessor {
  /// function to call after default go_back behaviour
  final void Function()? after;
  const GoBackPanel({this.after, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            router().pop();
            after?.call();
          },
          child: Icon(
            Icons.chevron_left,
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
