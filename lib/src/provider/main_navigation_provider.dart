// Flutter Modules
import 'package:flutter/material.dart';

class MainNavigationProvider extends ChangeNotifier {
  bool _modeUnlock = false;

  bool get modeUnlock => _modeUnlock;

  set modeUnlock(bool value) {
    if (_modeUnlock != value) {
      _modeUnlock = value;
      notifyListeners();
    }
  }
}
