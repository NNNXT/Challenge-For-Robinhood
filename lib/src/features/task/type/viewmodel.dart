// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/model/task/task.dart';
import 'package:challenge_for_robinhood/network/repository/task.dart';

class TypeViewmodel extends ChangeNotifier {
  final TaskRepository _taskRepository;

  final TaskType taskType;

  final List<Task> _taskList = [];

  bool _isLastPage = false;

  int _offset = 0;

  bool get isLastPage => _isLastPage;

  List<Task> get taskList => _taskList;

  Future<void> fetchTaskList({
    int limit = 10,
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      _offset = 0;
      _taskList.clear();
      notifyListeners();
    }

    try {
      var response = await _taskRepository.requestTaskList(
        taskType: taskType,
        limit: limit,
        offset: _offset,
      );

      _offset++;
      _isLastPage = (_offset == response.result?.totalPages);

      _taskList.addAll(response.result?.tasks ?? []);
      notifyListeners();
    } catch (_) {}
  }

  Future<void> fetchTaskListMore() async {
    try {
      var response = await _taskRepository.requestTaskList(
        taskType: taskType,
        offset: _offset,
      );
      _offset++;
      _isLastPage = (_offset == response.result?.totalPages);
      _taskList.addAll(response.result?.tasks ?? []);
      notifyListeners();
    } catch (_) {}
  }

  void removeTask({
    required Task task,
  }) {
    _taskList.remove(task);
    notifyListeners();
  }

  TypeViewmodel({
    required BuildContext context,
    required this.taskType,
  }) : _taskRepository = context.provide();
}
