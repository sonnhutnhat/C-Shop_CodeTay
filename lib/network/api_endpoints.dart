abstract final class ApiEndpoints {
  static const apiVersion = '/api/v1';

  static const login = '$apiVersion/auth/login';
  static const tokenRefresh = '$apiVersion/auth/token/refresh';
  static const logout = '$apiVersion/auth/logout';
}
