mixin ListMixin {
  List<T> appendList<T>(List<T> initialList, List<T> list) {
    return List.from(initialList)..addAll(list);
  }

  List<T> removeAt<T>(List<T> initialList, int index) {
    return List.from(initialList)..removeAt(index);
  }
}
