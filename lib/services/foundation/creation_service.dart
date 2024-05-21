mixin CreationService<T> {
  Future<T> create(T model);
  Future<List<T>> createAll(List<T> models);
}
