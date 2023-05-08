import 'package:flutter/material.dart';

class ActiveNavModel extends ChangeNotifier {
  int _activeNav = 0;
  int get activeNav => _activeNav;
  ActiveNavModel() {
    notifyListeners();
  }
  void setActiveNav(index) {
    _activeNav = index;
    notifyListeners();
  }
}
