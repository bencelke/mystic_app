import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../config/dev_flags.dart';
import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/card_of_day_service.dart';
import '../../core/utils/numerology_service.dart';
import '../../core/utils/user_profile_local.dart';
import '../../models/card_of_day_item.dart';
import '../../models/numerology_reading.dart';
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
  late final CardOfDayItem _todayCard;
  bool _heroVisible = false;
  bool _loadingDob = true;
  DateTime? _dob;
  NumerologyReading? _numerologyReading;

  @override
  void initState() {
    super.initState();
    _todayCard = getCardOfTheDay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _heroVisible = true;
        });
      }
    });
    _loadDob();
  }

  Future<void> _loadDob() async {
    final dob = await getDob();
    if (!mounted) return;
    setState(() {
      _loadingDob = false;
      _dob = dob;
      if (dob != null) {
        _numerologyReading = buildReading(
          dob,
          DateTime.now(),
          widget.controller.current,
        );
      }
    });
  }

  Future<void> _showDobPicker(BuildContext context) async {
    final locale = widget.controller.current;
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? now.subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked == null || !mounted) return;
    await setDob(picked);
    if (!mounted) return;
    setState(() {
      _dob = picked;
      _numerologyReading = buildReading(
        picked,
        DateTime.now(),
        widget.controller.current,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;
    final isLockedView = !kDevUnlockAll &&
        (widget.currentSection == 'archive' ||
            widget.currentSection == 'profile');

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
          if (_showPremiumDetails && !kDevUnlockAll)
            LockedSection(
              title: AppStrings.t(locale, 'full_reading_locked_title'),
              message: AppStrings.t(locale, 'full_reading_locked_message'),
              ctaLabel: AppStrings.t(locale, 'unlock_button'),
            ),
          const SizedBox(height: 32),
          _buildDetailGrid(context),
          const SizedBox(height: 32),
          if (!_loadingDob) ...[
            _buildNumerologySection(context),
            const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }

  Widget _buildNumerologySection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;

    if (_numerologyReading == null) {
      return MysticCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.t(locale, 'numerology_title'),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 60,
              height: 2,
              color: AppColors.mutedGold,
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.t(locale, 'numerology_setup_need_dob'),
              style: textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.t(locale, 'numerology_setup_bullet_life_path'),
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.t(locale, 'numerology_setup_bullet_personal_day'),
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _showDobPicker(context),
              child: Text(
                AppStrings.t(locale, 'numerology_add_dob'),
                style: const TextStyle(color: AppColors.mutedGold),
              ),
            ),
          ],
        ),
      );
    }

    final r = _numerologyReading!;
    final isRu = locale == AppLocale.ru;
    final text = isRu ? r.textRu : r.textEn;
    final keywords = isRu ? r.keywordsRu : r.keywordsEn;
    final lifePathHeader = AppStrings.t(locale, 'numerology_life_path_header');
    final lifePathTitle = AppStrings.t(locale, 'numerology_lp_${r.lifePath}');

    return MysticCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.t(locale, 'numerology_title'),
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 60,
            height: 2,
            color: AppColors.mutedGold,
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.t(locale, 'numerology_personal_day'),
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${r.personalDay}',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.mutedGold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.t(locale, 'numerology_explain_personal_day_generic'),
            style: textTheme.bodySmall?.copyWith(
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$lifePathHeader ${r.lifePath} — $lifePathTitle',
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.t(locale, 'numerology_explain_life_path'),
            style: textTheme.bodySmall?.copyWith(
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: keywords
                .map(
                  (k) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mutedGold),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      k,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (r.personalDay == 7) ...[
            const SizedBox(height: 12),
            Text(
              AppStrings.t(locale, 'numerology_day7_what_this_means'),
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.t(locale, 'numerology_keyword_reflection'),
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.t(locale, 'numerology_keyword_intuition'),
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.t(locale, 'numerology_keyword_silence'),
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.t(locale, 'numerology_keyword_understanding'),
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;
    final preview = cardPreviewForLocale(_todayCard, locale);
    final full = cardTextForLocale(_todayCard, locale);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      opacity: _heroVisible ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.06),
              blurRadius: 14,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: MysticCard(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 2,
                            color: AppColors.mutedGold,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppStrings.t(locale, 'hero_card_label'),
                            style: textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
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
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 60,
                        height: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        color: AppColors.mutedGold,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          final rotate = Tween<double>(
                            begin: math.pi,
                            end: 0,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          );

                          return AnimatedBuilder(
                            animation: rotate,
                            child: child,
                            builder: (context, child) {
                              final isUnder =
                                  (child!.key != ValueKey(_showPremiumDetails));
                              final value =
                                  isUnder ? math.min(rotate.value, math.pi / 2) : rotate.value;
                              return Transform(
                                transform: Matrix4.rotationY(value),
                                alignment: Alignment.center,
                                child: child,
                              );
                            },
                          );
                        },
                        child: Text(
                          _showPremiumDetails ? full : preview,
                          key: ValueKey(_showPremiumDetails),
                          style: textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
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
                    const SizedBox(height: 24),
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
        ),
      ),
    );
  }

  Widget _buildDetailGrid(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = widget.controller.current;
    final fullText = cardTextForLocale(_todayCard, locale);
    final meaningLines = fullText
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    final meaningText = meaningLines.isEmpty
        ? AppStrings.t(locale, 'meaning_bullets')
        : meaningLines.take(3).map((line) => '• $line').join('\n');

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
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meaningText,
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
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
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.t(locale, 'action_bullets'),
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
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
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.t(locale, 'reflection_question'),
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
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
