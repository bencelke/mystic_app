import '../../core/i18n/app_locale.dart';
import '../../data/card_of_day_deck_emotional_clarity.dart';
import '../../models/card_of_day_item.dart';

CardOfDayItem getCardOfTheDay({DateTime? date, String? userId}) {
  final now = (date ?? DateTime.now()).toLocal();
  final dayOfYear = _dayOfYear(now);

  int hash = dayOfYear;
  if (userId != null && userId.isNotEmpty) {
    for (final codeUnit in userId.codeUnits) {
      hash = 31 * hash + codeUnit;
    }
  }

  final index = hash.abs() % emotionalClarityDeck.length;
  return emotionalClarityDeck[index];
}

int getCardOfTheDayIndex({DateTime? date, String? userId}) {
  final now = (date ?? DateTime.now()).toLocal();
  final dayOfYear = _dayOfYear(now);
  int hash = dayOfYear;
  if (userId != null && userId.isNotEmpty) {
    for (final codeUnit in userId.codeUnits) {
      hash = 31 * hash + codeUnit;
    }
  }
  return hash.abs() % emotionalClarityDeck.length;
}

const List<String> _cardImageAssets = [
  'assets/cards/web/01_star.png_result.webp',
  'assets/cards/web/02_path.png_result.webp',
  'assets/cards/web/03_gate.png_result.webp',
  'assets/cards/web/04_mirror.png_result.webp',
  'assets/cards/web/05_flame.png_result.webp',
  'assets/cards/web/06_key.png_result.webp',
  'assets/cards/web/07_compass.png_result.webp',
  'assets/cards/web/08_traveler.png_result.webp',
  'assets/cards/web/09_tree.png_result.webp',
  'assets/cards/web/10_dawn.png_result.webp',
  'assets/cards/web/11_tree.png_result.webp',
  'assets/cards/web/12_compass.png_result.webp',
  'assets/cards/web/13_moon.png_result.webp',
  'assets/cards/web/14_sun.png_result.webp',
  'assets/cards/web/15_bridge.png_result.webp',
  'assets/cards/web/16_book.png_result.webp',
  'assets/cards/web/17_lantern.png_result.webp',
  'assets/cards/web/18_storm.png_result.webp',
  'assets/cards/web/19_feather.png_result.webp',
  'assets/cards/web/20_shield.png_result.webp',
  'assets/cards/web/21_mountain.png_result.webp',
  'assets/cards/web/22_river.png_result.webp',
  'assets/cards/web/23_door.png_result.webp',
  'assets/cards/web/24_crown.png_result.webp',
  'assets/cards/web/25_garden.png_result.webp',
  'assets/cards/web/26_hourglass.png_result.webp',
  'assets/cards/web/27_ship.png_result.webp',
  'assets/cards/web/28_tower.png_result.webp',
  'assets/cards/web/29_circle.png_result.webp',
  'assets/cards/web/30_phoenix.png_result.webp',
];

String cardImageAssetForIndex(int index) {
  return _cardImageAssets[index % _cardImageAssets.length];
}

String cardTextForLocale(CardOfDayItem card, AppLocale locale) {
  switch (locale) {
    case AppLocale.ru:
      return card.textRu;
    case AppLocale.en:
      return card.textEn;
  }
}

String cardPreviewForLocale(
  CardOfDayItem card,
  AppLocale locale, {
  int maxChars = 120,
} ) {
  final full = cardTextForLocale(card, locale);
  final newlineIndex = full.indexOf('\n');
  String preview =
      newlineIndex != -1 ? full.substring(0, newlineIndex) : full;

  if (preview.length > maxChars) {
    preview = preview.substring(0, maxChars).trimRight();
    if (!preview.endsWith('…')) {
      preview = '$preview…';
    }
  }

  return preview;
}

int _dayOfYear(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1);
  return date.difference(startOfYear).inDays + 1;
}

