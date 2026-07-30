import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'configs/app_configs.dart';
import 'configs/app_env_config.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfigs.env = Environment.prod;
  await SystemChrome.setPreferredOrientations(
    const <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
  await NotificationService.init();
  runApp(const MyApp());
}
