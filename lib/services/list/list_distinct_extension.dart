extension ListDistinctExtension<T> on List<T> {
  List<T> distinct({bool inPlace = false}) {
    final Set ids = {};
    final list = inPlace ? this : List<T>.from(this);

    list.retainWhere((element) => ids.add(element));

    return list;
  }
}
