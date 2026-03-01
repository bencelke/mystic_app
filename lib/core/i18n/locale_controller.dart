import 'package:flutter/foundation.dart';

import 'app_locale.dart';

class LocaleController extends ChangeNotifier {
  AppLocale _current = AppLocale.en;

  AppLocale get current => _current;

  void switchTo(AppLocale locale) {
    if (_current == locale) return;
    _current = locale;
    notifyListeners();
  }
}
