// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_widget.dart';
import 'package:challenge_for_robinhood/model/task/task.dart';
import 'package:challenge_for_robinhood/navigator_route.dart';
import 'package:challenge_for_robinhood/src/features/task/type/screen.dart';
import 'package:challenge_for_robinhood/src/features/task/viewmodel.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) => BaseWidget<TaskViewmodel>(
        model: TaskViewmodel(context: context),
        onModelReady: (model) {},
        onPagePause: (model) {
          model.timeStampPause = DateTime.now();
        },
        onPageResume: (model) {
          if (model.updateTimeStampResume(DateTime.now())) {
            context.push(NavigatorRoutePath.lockScreen.goPath);
          }
        },
        builder: (_, model, __) {
          int currentTab = model.currentTab;
          return Scaffold(
            appBar: AppBar(
              title: Text('task.title'.tr(args: ['User'])),
            ),
            body: IndexedStack(
              index: currentTab,
              children: const <Widget>[
                TypeScreen(taskType: TaskType.todo),
                TypeScreen(taskType: TaskType.doing),
                TypeScreen(taskType: TaskType.done),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                model.currentTab = index;
              },
              currentIndex: currentTab,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.circle),
                  label: 'task.todo'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.personRunning),
                  label: 'task.doing'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.circleCheck),
                  label: 'task.done'.tr(),
                ),
              ],
            ),
          );
        },
      );
}
