class ArrayResponse<T> {
  const ArrayResponse({required this.data, this.message});

  final List<T> data;
  final String? message;
}
