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
  bool _isFirtLoading = false;
  bool _haveError = false;

  int _offset = 0;

  bool get isLastPage => _isLastPage;
  bool get isFirstLoading => _isFirtLoading;
  bool get haveError => _haveError;

  List<Task> get taskList => _taskList;

  Future<void> fetchTaskList({
    int limit = 10,
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      _offset = 0;
      _taskList.clear();
    }
    if (_haveError) {
      _haveError = false;
      notifyListeners();
    }
    _isFirtLoading = true;
    try {
      var response = await _taskRepository.requestTaskList(
        taskType: taskType,
        limit: limit,
        offset: _offset,
      );

      _offset++;
      _isLastPage = (_offset == response.result?.totalPages);

      _taskList.addAll(response.result?.tasks ?? []);
      _isFirtLoading = false;
    } catch (_) {
      _haveError = true;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchTaskListMore() async {
    if (_haveError) {
      _haveError = false;
      notifyListeners();
    }
    try {
      var response = await _taskRepository.requestTaskList(
        taskType: taskType,
        offset: _offset,
      );
      _offset++;
      _isLastPage = (_offset == response.result?.totalPages);
      _taskList.addAll(response.result?.tasks ?? []);
    } catch (_) {
      _haveError = true;
    } finally {
      notifyListeners();
    }
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
