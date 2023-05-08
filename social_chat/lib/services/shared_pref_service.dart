import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_chat/models/auth.model.dart';

class SharedPreferencesServices {
  static Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // static Future<Auth> getAuthData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final authJson = prefs.getString('auth');
  //   if (authJson != null) {
  //     final auth = Auth.fromJson(jsonDecode(authJson));
  //     return auth;
  //   } else {
  //     return Auth();
  //   }
  // }
}
