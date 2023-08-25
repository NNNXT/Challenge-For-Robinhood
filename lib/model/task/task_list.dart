// External Modules
import 'package:json_annotation/json_annotation.dart';

// Internal Modules
import 'package:challenge_for_robinhood/model/task/task.dart';

part 'task_list.g.dart';

@JsonSerializable(createToJson: false)
class TaskList {
  @JsonKey(defaultValue: [])
  List<Task> tasks;

  @JsonKey(defaultValue: 0)
  int pageNumber;

  @JsonKey(defaultValue: 0)
  int totalPages;

  TaskList({
    required this.tasks,
    required this.pageNumber,
    required this.totalPages,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => _$TaskListFromJson(json);
}
