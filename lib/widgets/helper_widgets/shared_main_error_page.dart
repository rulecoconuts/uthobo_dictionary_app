import 'package:flutter/material.dart';

class SharedMainErrorPage extends StatelessWidget {
  final dynamic error;
  final StackTrace? stackTrace;
  const SharedMainErrorPage({required this.error, this.stackTrace, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$error",
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
    );
  }
}
