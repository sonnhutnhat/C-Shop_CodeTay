import 'app_env_config.dart';

abstract final class AppConfigs {
  static const appName = 'C-Shop';

  static Environment env = Environment.prod;

  static String get baseUrl => env.baseUrl;

  static bool get enableNetworkLogs => env != Environment.prod;
}
