import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/storage/onboarding_storage.dart';
import '../../theme/app_colors.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({
    super.key,
    required this.controller,
    required this.onNext,
  });

  final LocaleController controller;
  final VoidCallback onNext;

  void _select(AppLocale locale) {
    controller.switchTo(locale);
    setSavedLanguage(locale);
    onNext();
  }

  @override
  Widget build(BuildContext context) {
    final locale = controller.current;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                AppStrings.t(locale, 'language_screen_title'),
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 48,
                height: 2,
                color: AppColors.mutedGold,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.t(locale, 'language_screen_subtitle'),
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _LanguageTile(
                label: AppStrings.t(locale, 'language_name_en'),
                onTap: () => _select(AppLocale.en),
              ),
              const SizedBox(height: 12),
              _LanguageTile(
                label: AppStrings.t(locale, 'language_name_ru'),
                onTap: () => _select(AppLocale.ru),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.background,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.mutedGold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
