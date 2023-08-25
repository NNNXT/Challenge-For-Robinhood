// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/src/provider/main_navigation_provider.dart';

class TaskViewmodel extends ChangeNotifier {
  final MainNavigationProvider _mainNavigationProvider;

  int _currentTab = 0;

  DateTime _timeStampPause = DateTime.now();
  DateTime _timeStampResume = DateTime.now();

  int get currentTab => _currentTab;

  DateTime? get _lastUnlock => _mainNavigationProvider.lastUnlock;
  DateTime get timeStampPause => _timeStampPause;

  bool _lockApp(DateTime value) {
    if (_lastUnlock != null && DateTime.now().difference(_lastUnlock!).inSeconds < 10) {
      return false;
    }
    return _timeStampResume.difference(_timeStampPause).inSeconds >= 10;
  }

  set currentTab(int value) {
    if (_currentTab != value) {
      _currentTab = value;
    }
    notifyListeners();
  }

  set timeStampPause(DateTime value) {
    _timeStampPause = value;
    notifyListeners();
  }

  bool updateTimeStampResume(DateTime value) {
    _timeStampResume = value;
    return _lockApp(value);
  }

  TaskViewmodel({
    required BuildContext context,
  }) : _mainNavigationProvider = context.provide();
}
