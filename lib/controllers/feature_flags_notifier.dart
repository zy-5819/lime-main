import 'package:flutter/material.dart';

class FeatureFlagsNotifier extends ChangeNotifier {
  String _flags = 'basic';
  String get flags => _flags;
  set flags(String value) {
    _flags = value;
    notifyListeners();
  }
}
