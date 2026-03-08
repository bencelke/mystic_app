import 'package:flutter/material.dart';

import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../shared/widgets/primary_button.dart';
import '../../theme/app_colors.dart';

class AppIntroScreen extends StatelessWidget {
  const AppIntroScreen({
    super.key,
    required this.controller,
    required this.onNext,
    required this.onBack,
  });

  final LocaleController controller;
  final VoidCallback onNext;
  final VoidCallback onBack;

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
              const SizedBox(height: 16),
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new),
                color: AppColors.textPrimary,
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  minimumSize: const Size(48, 48),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.t(locale, 'onboarding_intro_title'),
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
                AppStrings.t(locale, 'onboarding_intro_body'),
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              _Bullet(
                text: AppStrings.t(locale, 'onboarding_intro_bullet_card'),
              ),
              const SizedBox(height: 12),
              _Bullet(
                text: AppStrings.t(locale, 'onboarding_intro_bullet_number'),
              ),
              const SizedBox(height: 12),
              _Bullet(
                text: AppStrings.t(locale, 'onboarding_intro_bullet_ritual'),
              ),
              const Spacer(),
              PrimaryButton(
                label: AppStrings.t(locale, 'onboarding_continue'),
                onPressed: onNext,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: AppColors.mutedGold,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
          ),
        ),
      ],
    );
  }
}
