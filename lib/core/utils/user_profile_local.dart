import 'package:shared_preferences/shared_preferences.dart';

const String _keyDobIso = 'user_dob_iso';

Future<DateTime?> getDob() async {
  final prefs = await SharedPreferences.getInstance();
  final iso = prefs.getString(_keyDobIso);
  if (iso == null || iso.isEmpty) return null;
  return DateTime.tryParse(iso);
}

Future<void> setDob(DateTime dob) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_keyDobIso, dob.toIso8601String());
}
