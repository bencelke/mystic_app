import 'package:shared_preferences/shared_preferences.dart';

import '../i18n/app_locale.dart';

const String _keyOnboardingComplete = 'onboarding_complete';
const String _keyLanguage = 'selected_language';

Future<bool> isOnboardingComplete() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_keyOnboardingComplete) ?? false;
}

Future<void> setOnboardingComplete(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_keyOnboardingComplete, value);
}

Future<AppLocale?> getSavedLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.getString(_keyLanguage);
  if (code == null) return null;
  switch (code) {
    case 'ru':
      return AppLocale.ru;
    case 'en':
    default:
      return AppLocale.en;
  }
}

Future<void> setSavedLanguage(AppLocale locale) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_keyLanguage, locale == AppLocale.ru ? 'ru' : 'en');
}
