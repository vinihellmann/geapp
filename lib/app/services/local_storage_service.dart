import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<String?> getUser() async {
    final data = _prefs?.getString('user');
    return data != null ? jsonDecode(data) : null;
  }

  static Future<String?> getData(String key) async {
    final data = _prefs?.getString(key);
    return data != null ? jsonDecode(data) : null;
  }

  static Future<bool?> setData(String key, dynamic data) async {
    return await _prefs?.setString(key, jsonEncode(data));
  }

  static Future<bool?> removeData(String key) async {
    return await _prefs?.remove(key);
  }
}
