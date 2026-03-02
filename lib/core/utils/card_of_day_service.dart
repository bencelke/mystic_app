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

