import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension CacheForExtension on AutoDisposeRef<Object?> {
  void cacheFor(Duration duration) {
    // Keep state of provider alive
    final link = keepAlive();

    // Re-enable auto-dispose after [duration] has passed
    var timer = Timer(duration, link.close);

    onDispose(timer.cancel);
  }
}
