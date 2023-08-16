// Flutter Modules
import 'package:flutter/material.dart';

class MainNavigationProvider extends ChangeNotifier {
  DateTime? _lastUnlock;
  bool _firstTime = true;

  DateTime? get lastUnlock => _lastUnlock;
  bool get firstTime => _firstTime;

  set lastUnlock(DateTime? value) {
    if (_lastUnlock != value) {
      _lastUnlock = value;
      notifyListeners();
    }
  }

  set firstTime(bool value) {
    if (_firstTime != value) {
      _firstTime = value;
      notifyListeners();
    }
  }
}
