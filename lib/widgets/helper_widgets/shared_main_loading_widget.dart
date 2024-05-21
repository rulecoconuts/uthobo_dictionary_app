import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SharedMainLoadingWidget extends StatelessWidget {
  final double size;
  const SharedMainLoadingWidget({this.size = 100, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [Theme.of(context).colorScheme.primary],
        ));
  }
}
