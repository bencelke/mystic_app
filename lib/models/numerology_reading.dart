class NumerologyReading {
  const NumerologyReading({
    required this.dob,
    required this.forDate,
    required this.lifePath,
    required this.birthdayNumber,
    required this.attitudeNumber,
    required this.maturityNumber,
    required this.personalYear,
    required this.personalMonth,
    required this.personalDay,
    required this.titleRu,
    required this.titleEn,
    required this.textRu,
    required this.textEn,
    required this.keywordsRu,
    required this.keywordsEn,
  });

  final DateTime dob;
  final DateTime forDate;
  final int lifePath;
  final int birthdayNumber;
  final int attitudeNumber;
  final int maturityNumber;
  final int personalYear;
  final int personalMonth;
  final int personalDay;
  final String titleRu;
  final String titleEn;
  final String textRu;
  final String textEn;
  final List<String> keywordsRu;
  final List<String> keywordsEn;
}
