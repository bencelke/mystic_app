class NumberMeaning {
  const NumberMeaning({
    required this.titleRu,
    required this.titleEn,
    required this.keywordsRu,
    required this.keywordsEn,
    required this.shortTextRu,
    required this.shortTextEn,
  });

  final String titleRu;
  final String titleEn;
  final List<String> keywordsRu;
  final List<String> keywordsEn;
  final String shortTextRu;
  final String shortTextEn;
}

const Map<int, NumberMeaning> _meanings = {
  1: NumberMeaning(
    titleRu: 'Единица — Начало',
    titleEn: 'One — Beginning',
    keywordsRu: ['лидерство', 'инициатива', 'независимость', 'новая глава'],
    keywordsEn: ['leadership', 'initiative', 'independence', 'new chapter'],
    shortTextRu: 'День для первых шагов и ясных решений. Ваша энергия поддерживает новые начинания.',
    shortTextEn: 'A day for first steps and clear decisions. Your energy supports new beginnings.',
  ),
  2: NumberMeaning(
    titleRu: 'Двойка — Связь',
    titleEn: 'Two — Connection',
    keywordsRu: ['партнёрство', 'диалог', 'чувствительность', 'баланс'],
    keywordsEn: ['partnership', 'dialogue', 'sensitivity', 'balance'],
    shortTextRu: 'Уместны сотрудничество и внимание к другим. Мягкость приносит результат.',
    shortTextEn: 'Cooperation and attention to others are favoured. Softness brings results.',
  ),
  3: NumberMeaning(
    titleRu: 'Тройка — Выражение',
    titleEn: 'Three — Expression',
    keywordsRu: ['творчество', 'общение', 'радость', 'лёгкость'],
    keywordsEn: ['creativity', 'communication', 'joy', 'lightness'],
    shortTextRu: 'День для самовыражения и лёгкого общения. Позвольте идеям проявиться.',
    shortTextEn: 'A day for self-expression and light communication. Let ideas come through.',
  ),
  4: NumberMeaning(
    titleRu: 'Четвёрка — Основа',
    titleEn: 'Four — Foundation',
    keywordsRu: ['порядок', 'стабильность', 'труд', 'надёжность'],
    keywordsEn: ['order', 'stability', 'work', 'reliability'],
    shortTextRu: 'Подходящее время для структуры и практических дел. Маленькие шаги укрепляют основу.',
    shortTextEn: 'A good time for structure and practical matters. Small steps strengthen the foundation.',
  ),
  5: NumberMeaning(
    titleRu: 'Пятёрка — Изменение',
    titleEn: 'Five — Change',
    keywordsRu: ['свобода', 'опыт', 'адаптация', 'движение'],
    keywordsEn: ['freedom', 'experience', 'adaptation', 'movement'],
    shortTextRu: 'День может принести смену ритма. Гибкость помогает использовать новые возможности.',
    shortTextEn: 'The day may bring a shift of pace. Flexibility helps you use new opportunities.',
  ),
  6: NumberMeaning(
    titleRu: 'Шестёрка — Забота',
    titleEn: 'Six — Care',
    keywordsRu: ['дом', 'ответственность', 'гармония', 'забота'],
    keywordsEn: ['home', 'responsibility', 'harmony', 'care'],
    shortTextRu: 'Энергия дня поддерживает отношения и заботу о близких. Баланс даёт покой.',
    shortTextEn: 'The day supports relationships and caring for others. Balance brings peace.',
  ),
  7: NumberMeaning(
    titleRu: 'Семёрка — Глубина',
    titleEn: 'Seven — Depth',
    keywordsRu: ['размышление', 'интуиция', 'тишина', 'понимание'],
    keywordsEn: ['reflection', 'intuition', 'silence', 'understanding'],
    shortTextRu: 'Подходящее время для паузы и внутреннего ответа. Доверьтесь тихому знанию.',
    shortTextEn: 'A good time for pause and inner guidance. Trust quiet knowing.',
  ),
  8: NumberMeaning(
    titleRu: 'Восьмёрка — Результат',
    titleEn: 'Eight — Result',
    keywordsRu: ['сила', 'результат', 'материальное', 'авторитет'],
    keywordsEn: ['strength', 'result', 'material', 'authority'],
    shortTextRu: 'День поддерживает ясные цели и практические достижения. Действуйте уверенно.',
    shortTextEn: 'The day supports clear goals and practical achievement. Act with confidence.',
  ),
  9: NumberMeaning(
    titleRu: 'Девятка — Завершение',
    titleEn: 'Nine — Completion',
    keywordsRu: ['завершение', 'мудрость', 'отдача', 'целостность'],
    keywordsEn: ['completion', 'wisdom', 'giving', 'wholeness'],
    shortTextRu: 'Время подводить итоги и отпускать лишнее. Цикл завершается, открывая новое.',
    shortTextEn: 'A time to wrap up and release what no longer serves. The cycle completes, opening the new.',
  ),
  11: NumberMeaning(
    titleRu: 'Одиннадцать — Вдохновение',
    titleEn: 'Eleven — Inspiration',
    keywordsRu: ['интуиция', 'озарение', 'идеал', 'вдохновение'],
    keywordsEn: ['intuition', 'insight', 'ideal', 'inspiration'],
    shortTextRu: 'День тонких сигналов и озарений. Прислушайтесь к внутреннему голосу.',
    shortTextEn: 'A day of subtle signals and insight. Listen to your inner voice.',
  ),
  22: NumberMeaning(
    titleRu: 'Двадцать два — Строитель',
    titleEn: 'Twenty-Two — Builder',
    keywordsRu: ['мастерство', 'масштаб', 'реализация', 'наследие'],
    keywordsEn: ['mastery', 'scale', 'manifestation', 'legacy'],
    shortTextRu: 'Энергия дня поддерживает большие, но обоснованные планы. Доверяйте процессу.',
    shortTextEn: 'The day supports bold but grounded plans. Trust the process.',
  ),
  33: NumberMeaning(
    titleRu: 'Тридцать три — Учитель',
    titleEn: 'Thirty-Three — Teacher',
    keywordsRu: ['служение', 'забота', 'исцеление', 'мудрость'],
    keywordsEn: ['service', 'care', 'healing', 'wisdom'],
    shortTextRu: 'День для заботы о других и простой мудрости. Маленькие жесты имеют значение.',
    shortTextEn: 'A day for caring for others and simple wisdom. Small gestures matter.',
  ),
};

NumberMeaning getMeaningForNumber(int n) {
  if (_meanings.containsKey(n)) return _meanings[n]!;
  final single = n > 9 ? (n % 9 == 0 ? 9 : n % 9) : n;
  return _meanings[single] ?? _meanings[1]!;
}
