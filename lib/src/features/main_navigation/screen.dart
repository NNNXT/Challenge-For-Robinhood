// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_widget.dart';
import 'package:challenge_for_robinhood/src/features/lock_screen/screen.dart';
import 'package:challenge_for_robinhood/src/features/main_navigation/viewmodel.dart';
import 'package:challenge_for_robinhood/src/features/task/screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) => BaseWidget<MainNavigationViewModel>(
        model: MainNavigationViewModel(context: context),
        builder: (_, model, __) => model.firstTime ? const LockScreen() : const TaskScreen(),
      );
}
