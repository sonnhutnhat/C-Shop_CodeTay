import 'package:dio/dio.dart';

class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.statusCode,
    this.cause,
  });

  factory AppException.from(Object error) {
    if (error is AppException) return error;
    if (error is DioException) {
      final responseData = error.response?.data;
      final errorData =
          responseData is Map<String, dynamic> ? responseData['error'] : null;
      final errorMap = errorData is Map<String, dynamic> ? errorData : null;
      return AppException(
        message: errorMap?['message'] as String? ??
            error.message ??
            'Không thể kết nối đến máy chủ.',
        code: errorMap?['code'] as String?,
        statusCode: error.response?.statusCode,
        cause: error,
      );
    }
    return AppException(
      message: 'Đã xảy ra lỗi không xác định.',
      cause: error,
    );
  }

  final String message;
  final String? code;
  final int? statusCode;
  final Object? cause;

  @override
  String toString() => 'AppException($code, $statusCode, $message)';
}
