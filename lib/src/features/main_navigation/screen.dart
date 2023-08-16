// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge_for_robinhood/navigator_route.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(NavigatorRoutePath.lockScreen.goPath);
        },
      ),
    );
  }
}
