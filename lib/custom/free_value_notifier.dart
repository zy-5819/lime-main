import 'package:flutter/foundation.dart';

class FreeValueNotifier<T> extends ChangeNotifier
    implements ValueListenable<T> {
  FreeValueNotifier(this._value);

  @override
  T get value => _value;
  T _value;
  set value(T newValue) {
    if (newValue == _value) {
      return;
    }

    _value = newValue;
    notifyListeners();
  }

  void setValue(T newValue) {
    _value = newValue;
    notifyListeners();
  }
}
