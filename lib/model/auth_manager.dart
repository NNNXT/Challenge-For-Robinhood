// Flutter Modules
import 'dart:convert';

// External Modules
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final _instance = AuthManager();

  static AuthManager get instance => _instance;

  final _secureStorage = const FlutterSecureStorage();

  Future<bool> validatePassCode({required String hashPasscode}) async {
    // TODO : Change to validate passcode from backend
    String? passcode = await _secureStorage.read(key: 'passcode');
    if (passcode == null) {
      // Hash value of 123456
      String value = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92';
      _secureStorage.write(key: 'passcode', value: value);
      passcode = await _secureStorage.read(key: 'passcode');
    }
    return hashPasscode == passcode;
  }

  String convertToSha256(String passcode) {
    List<int> bytes = utf8.encode(passcode);
    return sha256.convert(bytes).toString();
  }
}
