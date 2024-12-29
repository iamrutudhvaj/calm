// Extensions for int to Durations
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension IntToDuration on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
  Duration get weeks => Duration(days: this * 7);
  Duration get months => Duration(days: this * 30);
  Duration get years => Duration(days: this * 365);
}

// Extension for String to check wheather the string is email address or not
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
}

// Extension on double to provide SizedBox of that size
extension SizedBoxExtension on num {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
  SizedBox get box => SizedBox(height: toDouble(), width: toDouble());
}

// Extension on String to provide String in Debug mode, otherwise null
extension DebugExtension on String {
  String? get debug => kDebugMode ? this : null;
}
