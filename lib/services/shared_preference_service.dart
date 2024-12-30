import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static late SharedPreferences _pref;

  // static init method
  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  // static method to save data in boolean
  static Future<void> setBool(String key, bool value) async {
    await _pref.setBool(key, value);
  }

  // static method to save data in string
  static Future<void> setString(String key, String value) async {
    await _pref.setString(key, value);
  }

  // static method to get boolean value from key
  static bool? getBool(String key) {
    return _pref.getBool(key);
  }

  // static method to get string value from key
  static String? getString(String key) {
    return _pref.getString(key);
  }
}

class SharedPreferenceKeys {
  static const String isFirstTime = "isFirstTime";
}
