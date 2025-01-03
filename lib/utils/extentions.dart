// Extensions for int to Durations
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension IntToDuration on int {
  Duration get milliseconds => Duration(milliseconds: this);
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

// Extension on BuildContext to provide height and width of the screen
extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension IntToMonth on int {
  static List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  String get month => months[this - 1];
}

extension IntToWeekday on int {
  static List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  String get weekday => weekdays[this - 1];
}
