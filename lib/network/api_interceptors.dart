import 'package:dio/dio.dart';

import '../database/secure_storage_helper.dart';
import 'request_id.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {
  ApiInterceptors({SecureStorageHelper? secureStorage})
      : _secureStorage = secureStorage ?? SecureStorageHelper.instance;

  final SecureStorageHelper _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent('X-Request-ID', generateRequestId);

    final method = options.method.toUpperCase();
    if (method != 'GET' && method != 'HEAD') {
      options.headers.putIfAbsent('X-Idempotency-Key', generateRequestId);
    }

    final token = await _secureStorage.getToken();
    if (token != null &&
        token.accessToken.isNotEmpty &&
        !options.headers.containsKey('Authorization')) {
      options.headers['Authorization'] = 'Bearer ${token.accessToken}';
    }

    final session = await _secureStorage.getSession();
    if (session != null) {
      if (session.tenantId.isNotEmpty) {
        options.headers.putIfAbsent('X-Tenant-ID', () => session.tenantId);
      }
      if (session.storeId.isNotEmpty) {
        options.headers.putIfAbsent('X-Store-ID', () => session.storeId);
      }
    }

    handler.next(options);
  }
}
