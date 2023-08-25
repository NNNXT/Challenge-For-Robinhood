// Internal Modules
import 'package:challenge_for_robinhood/model/task/task_list.dart';

class TaskListResponse {
  final TaskList? result;

  TaskListResponse({
    this.result,
  });

  factory TaskListResponse.fromJson(json) => TaskListResponse(
        result: TaskList.fromJson(json as Map<String, dynamic>? ?? {}),
      );
}
