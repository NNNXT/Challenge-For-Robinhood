// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
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

extension DateHelper on DateTime {
  String formatDate() {
    var formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) => year == other.year && month == other.month && day == other.day;

  int getDifferenceInDaysWithNow() {
    var now = DateTime.now();
    return now.difference(this).inDays;
  }
}

extension ScrollNotificationType on ScrollNotification {
  bool get isEndNotification => this is ScrollEndNotification;

  bool get isStartNotification => this is ScrollStartNotification;

  bool get isUpdateNotification => this is ScrollUpdateNotification;

  bool get isUserNotification => this is UserScrollNotification;

  bool get isLoadMoreNotification =>
      metrics.pixels > 0.0 && metrics.pixels >= metrics.maxScrollExtent && isEndNotification;
}
