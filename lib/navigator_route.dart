// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

// Screen
import 'package:challenge_for_robinhood/src/features/lock_screen/screen.dart';
import 'package:challenge_for_robinhood/src/features/main_navigation/screen.dart';
import 'package:challenge_for_robinhood/src/features/task/screen.dart';

enum NavigatorRoutePath { home, lockScreen, task }

extension NavigatorRoutePathExtension on NavigatorRoutePath {
  String get path {
    switch (this) {
      case NavigatorRoutePath.home:
        return '/';

      case NavigatorRoutePath.lockScreen:
        return 'lockScreen';

      case NavigatorRoutePath.task:
        return 'task';

      default:
        return '';
    }
  }

  String get goPath {
    switch (this) {
      case NavigatorRoutePath.lockScreen:
        return '/lockScreen';

      case NavigatorRoutePath.task:
        return '/task';

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
        GoRoute(
          path: NavigatorRoutePath.task.path,
          builder: (_, __) => const TaskScreen(),
        ),
      ],
    ),
  ],
);

MaterialApp materialApp(BuildContext context) => MaterialApp.router(
      title: 'Challange',
      routerConfig: _router,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.purple,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
