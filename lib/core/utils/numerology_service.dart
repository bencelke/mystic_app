import '../i18n/app_locale.dart';
import '../../data/numerology_meanings.dart';
import '../../models/numerology_reading.dart';

int sumDigits(int n) {
  int sum = 0;
  int x = n.abs();
  while (x > 0) {
    sum += x % 10;
    x ~/= 10;
  }
  return sum;
}

int reduceNumber(int n, {bool allowMaster = true}) {
  int x = n.abs();
  if (x == 0) return 0;
  if (allowMaster && (x == 11 || x == 22 || x == 33)) return x;
  while (x > 9 && !(allowMaster && (x == 11 || x == 22 || x == 33))) {
    x = sumDigits(x);
  }
  return x;
}

int lifePath(DateTime dob) {
  final d = dob.day;
  final m = dob.month;
  final y = dob.year;
  return reduceNumber(sumDigits(d) + sumDigits(m) + sumDigits(y));
}

int birthdayNumber(DateTime dob) {
  return reduceNumber(dob.day);
}

int attitudeNumber(DateTime dob) {
  return reduceNumber(dob.day + dob.month);
}

int maturityNumber(DateTime dob) {
  return reduceNumber(lifePath(dob) + birthdayNumber(dob));
}

int personalYear(DateTime dob, DateTime forDate) {
  final dayMonth = sumDigits(dob.day) + sumDigits(dob.month);
  final yearSum = sumDigits(forDate.year);
  return reduceNumber(dayMonth + yearSum);
}

int personalMonth(DateTime dob, DateTime forDate) {
  return reduceNumber(personalYear(dob, forDate) + forDate.month);
}

int personalDay(DateTime dob, DateTime forDate) {
  return reduceNumber(personalMonth(dob, forDate) + forDate.day);
}

NumerologyReading buildReading(
  DateTime dob,
  DateTime forDate,
  AppLocale locale,
) {
  final py = personalYear(dob, forDate);
  final pd = personalDay(dob, forDate);
  final meaning = getMeaningForNumber(pd);
  String textRu = meaning.shortTextRu;
  String textEn = meaning.shortTextEn;
  if (py == 8) {
    textRu = '$textRu Сегодня особенно уместно уделить внимание практическим шагам и ресурсам.';
    textEn = '$textEn Today is a good day to focus on practical steps and resources.';
  } else if (py == 9) {
    textRu = '$textRu День подходит для завершения циклов и благодарности.';
    textEn = '$textEn A day to complete cycles and practice gratitude.';
  }
  return NumerologyReading(
    dob: dob,
    forDate: forDate,
    lifePath: lifePath(dob),
    birthdayNumber: birthdayNumber(dob),
    attitudeNumber: attitudeNumber(dob),
    maturityNumber: maturityNumber(dob),
    personalYear: py,
    personalMonth: personalMonth(dob, forDate),
    personalDay: pd,
    titleRu: meaning.titleRu,
    titleEn: meaning.titleEn,
    textRu: textRu,
    textEn: textEn,
    keywordsRu: meaning.keywordsRu,
    keywordsEn: meaning.keywordsEn,
  );
}
