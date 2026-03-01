import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel();

  String _message = 'Mystic Day 1';

  String get message => _message;

  void setMessage(String value) {
    if (value == _message) {
      return;
    }
    _message = value;
    notifyListeners();
  }
}
