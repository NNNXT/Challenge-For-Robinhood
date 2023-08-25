// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Internal Modules
import 'package:challenge_for_robinhood/navigator_route.dart';

// Provider Modules
import 'package:challenge_for_robinhood/network/repository/task.dart';
import 'package:challenge_for_robinhood/src/provider/main_navigation_provider.dart';
import 'package:challenge_for_robinhood/src/provider/todo_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> repositories = [
      Provider.value(value: TaskRepository()),
    ];
    return MultiProvider(
      providers: [
        ...repositories,
        ChangeNotifierProvider<MainNavigationProvider>(
          create: (_) => MainNavigationProvider(),
        ),
        ChangeNotifierProvider<TodoProvider>(
          create: (_) => TodoProvider(),
        ),
      ],
      child: materialApp(context),
    );
  }
}
