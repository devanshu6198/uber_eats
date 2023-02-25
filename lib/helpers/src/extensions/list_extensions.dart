import 'dart:collection';

extension $IterableExtension<T> on Iterable<T> {
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}

extension $NullableIterableExtension<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrNotEmpty => this != null && this!.isNotEmpty;
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E element, int index) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }

  /*List<E> distinctBy(predicate(E selector)) {
    final set = HashSet();
    final List<E> list = [];
    toList().forEach((e) {
      final key = predicate(e);
      if (set.add(key)) {
        list.add(e);
      }
    });

    return list;
  }*/

  Map<K, List<T>> groupBy<T, K>(K key(T e)) {
    var map = <K, List<T>>{};

    for (final element in this) {
      var list = map.putIfAbsent(key(element as T), () => []);
      list.add(element);
    }
    return map;
  }
}

