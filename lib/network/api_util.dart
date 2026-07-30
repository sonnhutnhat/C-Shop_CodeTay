import 'package:dio/dio.dart';

import '../configs/app_configs.dart';
import 'api_interceptors.dart';

abstract final class ApiUtil {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfigs.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}
