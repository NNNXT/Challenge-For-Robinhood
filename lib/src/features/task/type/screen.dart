// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:flutter_slidable/flutter_slidable.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/base/base_widget.dart';
import 'package:challenge_for_robinhood/model/task/task.dart';
import 'package:challenge_for_robinhood/src/features/task/type/viewmodel.dart';

class TypeScreen extends StatelessWidget {
  final TaskType taskType;

  const TypeScreen({
    required this.taskType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseWidget<TypeViewmodel>(
        model: TypeViewmodel(
          context: context,
          taskType: taskType,
        ),
        onModelReady: (model) => model.fetchTaskList(),
        builder: (_, model, __) {
          List<Task> taskList = model.taskList;
          return RefreshIndicator(
            onRefresh: () => model.fetchTaskList(forceRefresh: true),
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index) {
                bool isSameDate = true;
                bool firstIndex = index == 0;

                TextStyle textStyle = const TextStyle(
                  color: Colors.purple,
                );

                Task task = taskList[index];

                String dateString = task.createdAt.toString();

                DateTime date = DateTime.parse(dateString);

                Slidable cardTask = Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          model.removeTask(task: task);
                        },
                        backgroundColor: Colors.purple,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: textStyle,
                      ),
                      subtitle: Text(task.description),
                    ),
                  ),
                );

                if (firstIndex) {
                  isSameDate = false;
                } else {
                  String prevDateString = taskList[index - 1].createdAt.toString();
                  DateTime prevDate = DateTime.parse(prevDateString);
                  isSameDate = date.isSameDate(prevDate);
                }

                if (firstIndex || !(isSameDate)) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        date.formatDate(),
                        style: textStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      cardTask,
                    ],
                  );
                } else {
                  return cardTask;
                }
              },
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemCount: taskList.length,
            ),
          );
        },
      );
}
