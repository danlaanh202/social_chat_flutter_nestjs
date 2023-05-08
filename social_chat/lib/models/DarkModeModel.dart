import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> _getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool('isDarkMode') ?? false;
}

Future<void> _setTheme(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setBool('isDarkMode', value);
}

class DarkModeModel extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  DarkModeModel() {
    _getTheme().then((value) {
      _isDarkMode = value;
      notifyListeners();
    });
  }
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _setTheme(_isDarkMode);
    notifyListeners();
  }
}
