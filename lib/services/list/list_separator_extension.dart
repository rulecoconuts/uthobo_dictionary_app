extension ListSeparatorExtension<T> on Iterable<T> {
  Iterable<T> separator(T Function() divider) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield divider.call();
        yield iterator.current;
      }
    }
  }
}
