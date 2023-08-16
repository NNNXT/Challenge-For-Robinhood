// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

extension BuildContextProvide on BuildContext {
  T provide<T>({bool listen = true}) => Provider.of<T>(
        this,
        listen: listen,
      );

  MediaQueryData get media => MediaQuery.of(this);

  void showToast({required String msg}) {
    Fluttertoast.showToast(msg: msg);
  }
}
