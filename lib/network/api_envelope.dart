class ApiEnvelope<T> {
  const ApiEnvelope({
    required this.data,
    this.message,
    this.requestId,
  });

  final T data;
  final String? message;
  final String? requestId;
}
