class CardOfDayItem {
  const CardOfDayItem({
    required this.id,
    required this.textRu,
    required this.textEn,
    this.tags = const <String>[],
  });

  final String id;
  final String textRu;
  final String textEn;
  final List<String> tags;
}

