// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/src/provider/main_navigation_provider.dart';

class TodoViewmodel extends ChangeNotifier {
  final MainNavigationProvider _mainNavigationProvider;
  DateTime _timeStampPause = DateTime.now();
  DateTime _timeStampResume = DateTime.now();

  DateTime? get _lastUnlock => _mainNavigationProvider.lastUnlock;

  bool _lockApp(DateTime value) {
    if (_lastUnlock != null && DateTime.now().difference(_lastUnlock!).inSeconds < 10) {
      return false;
    }
    return _timeStampResume.difference(_timeStampPause).inSeconds >= 10;
  }

  void updateTimeStampPause(DateTime value) {
    _timeStampPause = value;
  }

  bool updateTimeStampResume(DateTime value) {
    _timeStampResume = value;
    return _lockApp(value);
  }

  TodoViewmodel({
    required BuildContext context,
  }) : _mainNavigationProvider = context.provide();
}
