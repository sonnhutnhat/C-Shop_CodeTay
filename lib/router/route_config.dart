import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/app_start/splash/splash_page.dart';

abstract final class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();
  static final routeObserver = RouteObserver<PageRoute<dynamic>>();

  static const splash = '/';

  static final router = GoRouter(
    navigatorKey: navigationKey,
    initialLocation: splash,
    observers: <NavigatorObserver>[routeObserver],
    routes: <RouteBase>[
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
    ],
  );
}
