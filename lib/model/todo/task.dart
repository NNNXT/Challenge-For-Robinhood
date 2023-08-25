// External Modules
import 'package:json_annotation/json_annotation.dart';

// Internal Modules
import 'package:challenge_for_robinhood/network/datetime_converter.dart';

part 'task.g.dart';

const _kTypeToDo = 'todo';
const _kTypeDoing = 'doing';
const _kTypeDone = 'done';

enum TaskType { todo, doing, done }

@JsonSerializable(createToJson: false)
@CustomDateTimeConverter()
class Task {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String description;

  DateTime? createdAt;

  @JsonKey(defaultValue: '')
  String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

extension ProductItemTypeString on String {
  TaskType get toTaskType {
    switch (toLowerCase()) {
      case _kTypeDoing:
        return TaskType.doing;

      case _kTypeDone:
        return TaskType.done;

      default:
        return TaskType.todo;
    }
  }
}

extension BannerTypeConverter on TaskType {
  String get toRawValue {
    switch (this) {
      case TaskType.todo:
        return _kTypeToDo;

      case TaskType.doing:
        return _kTypeDoing;

      case TaskType.done:
        return _kTypeDone;
    }
  }
}
