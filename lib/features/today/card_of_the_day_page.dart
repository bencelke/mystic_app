import 'package:flutter/material.dart';

import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../shared/widgets/locked_section.dart';
import '../../shared/widgets/mystic_card.dart';
import '../../shared/widgets/primary_button.dart';
import '../../theme/app_colors.dart';

class CardOfTheDayPage extends StatefulWidget {
  const CardOfTheDayPage({
    super.key,
    required this.controller,
    required this.currentSection,
  });

  final LocaleController controller;
  final String currentSection;

  @override
  State<CardOfTheDayPage> createState() => _CardOfTheDayPageState();
}

class _CardOfTheDayPageState extends State<CardOfTheDayPage> {
  bool _showPremiumDetails = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;
    final isLockedView =
        widget.currentSection == 'archive' || widget.currentSection == 'profile';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.t(locale, 'card_of_day_title'),
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.t(locale, 'card_subtitle'),
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          if (isLockedView) ...[
            LockedSection(
              title: AppStrings.t(locale, 'view_locked_title'),
              message: AppStrings.t(locale, 'view_locked_message'),
            ),
            const SizedBox(height: 24),
          ],
          _buildHero(context),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: AppStrings.t(locale, 'reveal_button'),
                  onPressed: () {
                    setState(() {
                      _showPremiumDetails = true;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.t(locale, 'saved_label')),
                      ),
                    );
                  },
                  child: Text(AppStrings.t(locale, 'save_button')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_showPremiumDetails)
            LockedSection(
              title: AppStrings.t(locale, 'full_reading_locked_title'),
              message: AppStrings.t(locale, 'full_reading_locked_message'),
              ctaLabel: AppStrings.t(locale, 'unlock_button'),
            ),
          const SizedBox(height: 32),
          _buildDetailGrid(context),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;

    return MysticCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;

          final left = Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 180),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 2,
                      color: AppColors.mutedGold,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.t(locale, 'hero_card_label'),
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          );

          final right = Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.t(locale, 'hero_title'),
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.t(locale, 'hero_interpretation'),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                left,
                const SizedBox(height: 16),
                right,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              left,
              const SizedBox(width: 24),
              right,
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailGrid(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 800;
        final crossAxisCount = isNarrow ? 1 : 3;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MysticCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.t(locale, 'meaning_title'),
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.t(locale, 'meaning_bullets'),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            MysticCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.t(locale, 'action_title'),
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.t(locale, 'action_bullets'),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            MysticCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.t(locale, 'reflection_title'),
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.t(locale, 'reflection_question'),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
