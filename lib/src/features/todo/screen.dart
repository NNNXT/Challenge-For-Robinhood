// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_widget.dart';
import 'package:challenge_for_robinhood/navigator_route.dart';
import 'package:challenge_for_robinhood/src/features/todo/viewmodel.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TodoViewmodel>(
      model: TodoViewmodel(context: context),
      onModelReady: (model) {},
      onPagePause: (model) {
        model.updateTimeStampPause(DateTime.now());
      },
      onPageResume: (model) {
        if (model.updateTimeStampResume(DateTime.now())) {
          context.go(NavigatorRoutePath.lockScreen.goPath);
        }
      },
      builder: (_, model, __) {
        return const Scaffold(
          body: Center(),
        );
      },
    );
  }
}
