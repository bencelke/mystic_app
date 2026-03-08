import 'package:flutter/material.dart';

import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../shared/widgets/mystic_logo.dart';
import '../../shared/widgets/primary_button.dart';
import '../../theme/app_colors.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({
    super.key,
    required this.controller,
    required this.onNext,
    this.onBack,
  });

  final LocaleController controller;
  final VoidCallback onNext;
  final VoidCallback? onBack;

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
            children: [
              const SizedBox(height: 16),
              if (onBack != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: AppColors.textPrimary,
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(48, 48),
                    ),
                  ),
                ),
              if (onBack != null) const SizedBox(height: 8),
              const MysticLogo(size: 56),
              const SizedBox(height: 32),
              Text(
                AppStrings.t(locale, 'onboarding_welcome_title'),
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 48,
                height: 2,
                color: AppColors.mutedGold,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.t(locale, 'onboarding_welcome_subtitle'),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: AppStrings.t(locale, 'onboarding_get_started'),
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
