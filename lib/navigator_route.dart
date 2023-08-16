// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

// Screen
import 'package:challenge_for_robinhood/src/features/lock_screen/screen.dart';
import 'package:challenge_for_robinhood/src/features/main_navigation/screen.dart';

enum NavigatorRoutePath { home, lockScreen }

extension NavigatorRoutePathExtension on NavigatorRoutePath {
  String get path {
    switch (this) {
      case NavigatorRoutePath.home:
        return '/';

      case NavigatorRoutePath.lockScreen:
        return 'lockScreen';

      default:
        return '';
    }
  }

  String get goPath {
    switch (this) {
      case NavigatorRoutePath.lockScreen:
        return '/lockScreen';

      default:
        return '';
    }
  }
}

var _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: NavigatorRoutePath.home.path,
      builder: (_, __) => const MainNavigation(),
      routes: <RouteBase>[
        GoRoute(
          path: NavigatorRoutePath.lockScreen.path,
          builder: (_, __) => const LockScreen(),
        ),
      ],
    ),
  ],
);

MaterialApp materialApp(BuildContext context) => MaterialApp.router(
      title: 'Challange',
      routerConfig: _router,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
