class Paged<T> {
  const Paged({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<T> items;
  final int total;
  final int skip;
  final int limit;

  bool get hasMore => skip + items.length < total;

  Paged<R> map<R>(R Function(T item) mapper) {
    return Paged<R>(
      items: items.map(mapper).toList(growable: false),
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}
