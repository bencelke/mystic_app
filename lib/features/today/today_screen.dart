import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../shared/widgets/mystic_card.dart';
import '../../theme/app_colors.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final locale = controller.current;
    final textTheme = Theme.of(context).textTheme;

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
                      AppStrings.t(locale, 'card_subtitle'),
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.t(locale, 'today_card_placeholder'),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedGold,
                        fontStyle: FontStyle.italic,
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
                      AppStrings.t(locale, 'numerology_personal_day'),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.t(locale, 'today_number_placeholder'),
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.t(locale, 'today_number_hint'),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedGold,
                        fontStyle: FontStyle.italic,
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
