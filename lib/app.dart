// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:provider/provider.dart';

// Internal Modules
import 'package:challenge_for_robinhood/navigator_route.dart';

// Provider Modules
import 'package:challenge_for_robinhood/src/provider/main_navigation_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<MainNavigationProvider>(
            create: (_) => MainNavigationProvider(),
          ),
        ],
        child: materialApp(context),
      );
}
