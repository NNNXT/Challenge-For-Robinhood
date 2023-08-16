// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/model/auth_manager.dart';
import 'package:challenge_for_robinhood/src/provider/main_navigation_provider.dart';

class LockScreenViewmodel extends ChangeNotifier {
  final MainNavigationProvider _mainNavigationProvider;

  String _passcode = '';

  String get passcode => _passcode;
  bool get firstTime => _mainNavigationProvider.firstTime;
  bool get showRemoveButton => _passcode.isNotEmpty;
  int get passcodeLength => _passcode.length;

  Future<bool?> updatePasscode({required String value}) async {
    if (_passcode.length < 6) {
      _passcode = _passcode + value;
      if (_passcode.length == 6) {
        return checkPasscode(value: value);
      }
      notifyListeners();
    }
    return null;
  }

  Future<bool?> checkPasscode({required String value}) async {
    AuthManager auth = AuthManager.instance;
    String hashPasscode = auth.convertToSha256(_passcode);
    bool passwordMatch = await auth.validatePassCode(hashPasscode: hashPasscode);
    if (!passwordMatch) {
      _passcode = '';
    }
    notifyListeners();
    return passwordMatch;
  }

  void removePasscode() {
    if (_passcode.isNotEmpty) {
      _passcode = _passcode.substring(0, _passcode.length - 1);
      notifyListeners();
    }
  }

  void updateLastUnlock() {
    _mainNavigationProvider.lastUnlock = DateTime.now();
  }

  void updateFirstTime() {
    _mainNavigationProvider.firstTime = false;
  }

  LockScreenViewmodel({
    required BuildContext context,
  }) : _mainNavigationProvider = context.provide();
}
