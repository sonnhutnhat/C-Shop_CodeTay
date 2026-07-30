class ObjectResponse<T> {
  const ObjectResponse({required this.data, this.message});

  final T data;
  final String? message;
}
