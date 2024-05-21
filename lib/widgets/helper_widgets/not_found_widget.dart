import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String error;
  const NotFoundWidget({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      error,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Color(0xFF575353), fontWeight: FontWeight.w600),
    ));
  }
}
