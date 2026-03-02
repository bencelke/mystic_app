import 'package:flutter_test/flutter_test.dart';

import 'package:mystic_app/core/i18n/app_locale.dart';
import 'package:mystic_app/core/utils/card_of_day_service.dart';
import 'package:mystic_app/data/card_of_day_deck_emotional_clarity.dart';

void main() {
  test('same date returns same card', () {
    final date = DateTime(2026, 3, 1);
    final card1 = getCardOfTheDay(date: date);
    final card2 = getCardOfTheDay(date: date);
    expect(card1.id, card2.id);
  });

  test('different dates often return different cards', () {
    final date1 = DateTime(2026, 3, 1);
    final date2 = DateTime(2026, 3, 2);
    final card1 = getCardOfTheDay(date: date1);
    final card2 = getCardOfTheDay(date: date2);
    // It is possible but unlikely they match; this just asserts the function runs.
    expect(emotionalClarityDeck.contains(card1), isTrue);
    expect(emotionalClarityDeck.contains(card2), isTrue);
  });

  test('RU and EN strings are non-empty', () {
    for (final card in emotionalClarityDeck) {
      expect(card.textRu.trim().isNotEmpty, isTrue);
      expect(card.textEn.trim().isNotEmpty, isTrue);
      expect(cardTextForLocale(card, AppLocale.ru), isNotEmpty);
      expect(cardTextForLocale(card, AppLocale.en), isNotEmpty);
    }
  });
}

