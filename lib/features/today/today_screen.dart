import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/card_of_day_service.dart';
import '../../core/utils/numerology_service.dart';
import '../../data/numerology_meanings.dart';
import '../../models/card_of_day_item.dart';
import '../../shared/widgets/mystic_card.dart';
import '../../theme/app_colors.dart';
import '../card/card_screen.dart';
import '../number/number_screen.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final locale = controller.current;
    final textTheme = Theme.of(context).textTheme;

    final CardOfDayItem card = getCardOfTheDay();
    final String cardPreview = cardPreviewForLocale(card, locale);

    final DateTime today = DateTime.now();
    final int coreNumber =
        reduceNumber(sumDigits(today.day) + sumDigits(today.month) + sumDigits(today.year));
    final meaning = getMeaningForNumber(coreNumber);
    final bool isRu = locale == AppLocale.ru;
    final String numberTitle = isRu ? meaning.titleRu : meaning.titleEn;
    final String numberShort = isRu ? meaning.shortTextRu : meaning.shortTextEn;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(locale),
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.t(locale, 'today_guidance_placeholder'),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 28),
              _sectionLabel(
                context,
                AppStrings.t(locale, 'card_of_day_title'),
              ),
              const SizedBox(height: 12),
              MysticCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CardScreen(controller: controller),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 2,
                      color: AppColors.mutedGold,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.t(locale, 'card_of_day_title'),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cardPreview,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionLabel(
                context,
                AppStrings.t(locale, 'numerology_title'),
              ),
              const SizedBox(height: 12),
              MysticCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NumberScreen(controller: controller),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 2,
                      color: AppColors.mutedGold,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$coreNumber',
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.mutedGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      numberTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      numberShort,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
    );
  }

  String _greeting(AppLocale locale) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return locale == AppLocale.ru ? 'Доброе утро' : 'Good morning';
    }
    if (hour < 18) {
      return locale == AppLocale.ru ? 'Добрый день' : 'Good afternoon';
    }
    return locale == AppLocale.ru ? 'Добрый вечер' : 'Good evening';
  }
}
