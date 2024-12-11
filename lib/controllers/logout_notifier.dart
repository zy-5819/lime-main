import 'package:flutter/material.dart';

class LogoutNotifier extends ChangeNotifier {
  bool _unavailable = false;
  bool get unavailable => _unavailable;
  set unavailable(bool value) {
    _unavailable = value;
    notifyListeners();
  }
}

final logoutNotifier = LogoutNotifier();
