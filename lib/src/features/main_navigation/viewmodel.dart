// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/src/provider/main_navigation_provider.dart';

class MainNavigationViewModel extends ChangeNotifier {
  final MainNavigationProvider _mainNavigationProvider;

  bool get modeUnlock => _mainNavigationProvider.modeUnlock;

  void updateModeUnlock() {
    _mainNavigationProvider.modeUnlock = !modeUnlock;
    notifyListeners();
  }

  MainNavigationViewModel({
    required BuildContext context,
  }) : _mainNavigationProvider = context.provide();
}
