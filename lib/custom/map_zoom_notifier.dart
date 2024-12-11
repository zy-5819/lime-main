import 'package:flutter/material.dart';

class MapZoomNotifier extends ChangeNotifier {
  double _scale = 1;

  set scale(double value) {
    _scale = value;
    notifyListeners();
  }

  double get scale => _scale;
}
