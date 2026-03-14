import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/card_of_day_service.dart';
import '../../core/utils/numerology_service.dart';
import '../../data/numerology_meanings.dart';
import '../../models/card_of_day_item.dart';
import '../../shared/widgets/card_reveal_content.dart';
import '../../theme/app_colors.dart';
import '../number/number_screen.dart';

const String _kTextureAsset =
    'assets/textures/web-texture/lucid-origin_paper_texture__result.webp';
const String _kOrnamentAsset =
    'assets/ornaments/web-ornament/lucid-ornament.webp';

// Match reference: soft warm shadows, rounded luxury cards
const double _kPanelRadius = 22;
const double _kCardImageRadius = 16;
const List<BoxShadow> _kPanelShadow = [
  BoxShadow(
    color: Color(0x08000000),
    blurRadius: 28,
    offset: Offset(0, 6),
  ),
  BoxShadow(
    color: Color(0x05B89B5E),
    blurRadius: 32,
    offset: Offset(0, 8),
  ),
];
const List<BoxShadow> _kImageShadow = [
  BoxShadow(
    color: Color(0x09000000),
    blurRadius: 20,
    offset: Offset(0, 4),
  ),
  BoxShadow(
    color: Color(0x05B89B5E),
    blurRadius: 22,
    offset: Offset(0, 5),
  ),
];

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final locale = controller.current;
    final textTheme = Theme.of(context).textTheme;

    final CardOfDayItem card = getCardOfTheDay();
    final String cardPreview = cardPreviewForLocale(card, locale);
    final int cardIndex = getCardOfTheDayIndex();
    final String cardImageAsset = cardImageAssetForIndex(cardIndex);

    final DateTime today = DateTime.now();
    final int coreNumber = reduceNumber(
        sumDigits(today.day) + sumDigits(today.month) + sumDigits(today.year));
    final meaning = getMeaningForNumber(coreNumber);
    final bool isRu = locale == AppLocale.ru;
    final String numberTitle = isRu ? meaning.titleRu : meaning.titleEn;
    final String numberShort = isRu ? meaning.shortTextRu : meaning.shortTextEn;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                _greeting(locale),
                style: textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.25,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.t(locale, 'today_guidance_placeholder'),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 48),
              _sectionHeader(
                context,
                AppStrings.t(locale, 'card_of_day_title'),
              ),
              const SizedBox(height: 22),
              _CardOfDayHero(
                cardImageAsset: cardImageAsset,
                cardTitle: AppStrings.t(locale, 'card_of_day_title'),
                cardPreview: cardPreview,
                cardLabel: card.tags.isNotEmpty ? card.tags.first : null,
                textureAsset: _kTextureAsset,
                ornamentAsset: _kOrnamentAsset,
                buttonLabel: AppStrings.t(locale, 'reveal_button'),
                onTap: () => _openCardDetailSheet(context, controller),
              ),
              const SizedBox(height: 36),
              _sectionHeader(
                context,
                AppStrings.t(locale, 'numerology_title'),
              ),
              const SizedBox(height: 22),
              _NumerologyPanel(
                coreNumber: coreNumber,
                numberTitle: numberTitle,
                numberShort: numberShort,
                textureAsset: _kTextureAsset,
                ornamentAsset: _kOrnamentAsset,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          NumberScreen(controller: controller),
                    ),
                  );
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  /// Section title with thin gold decorative line to the right (reference layout).
  Widget _sectionHeader(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.15,
                height: 1.3,
              ),
        ),
        const SizedBox(width: 14),
        Container(
          width: 40,
          height: 1.5,
          color: AppColors.mutedGold,
        ),
      ],
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

  static void _openCardDetailSheet(
    BuildContext context,
    LocaleController controller,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _CardDetailSheet(controller: controller),
    );
  }
}

/// Full card reading in a modal sheet so bottom nav stays visible.
class _CardDetailSheet extends StatelessWidget {
  const _CardDetailSheet({required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final locale = controller.current;
    final textTheme = Theme.of(context).textTheme;
    final card = getCardOfTheDay();
    final fullText = cardTextForLocale(card, locale);
    final cardIndex = getCardOfTheDayIndex();
    final cardImageAsset = cardImageAssetForIndex(cardIndex);
    final title = AppStrings.t(locale, 'card_of_day_title');
    final reflectionTitle = AppStrings.t(locale, 'reflection_title');
    final reflectionQuestion = AppStrings.t(locale, 'reflection_question');

    final maxH = MediaQuery.of(context).size.height * 0.88;

    return Container(
      height: maxH,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 22),
                      color: AppColors.textSecondary,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.surfaceCream,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCream,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.mutedGold.withValues(alpha: 0.18),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: CardRevealContent(
                      cardImageAsset: cardImageAsset,
                      title: title,
                      meaningText: fullText,
                      reflectionTitle: reflectionTitle,
                      reflectionQuestion: reflectionQuestion,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

/// Hero block: dominant card image (left) + reading panel (right); single elegant composition.
class _CardOfDayHero extends StatelessWidget {
  const _CardOfDayHero({
    required this.cardImageAsset,
    required this.cardTitle,
    required this.cardPreview,
    this.cardLabel,
    required this.textureAsset,
    required this.ornamentAsset,
    required this.buttonLabel,
    required this.onTap,
  });

  final String cardImageAsset;
  final String cardTitle;
  final String cardPreview;
  final String? cardLabel;
  final String textureAsset;
  final String ornamentAsset;
  final String buttonLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kPanelRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kPanelRadius),
            boxShadow: _kPanelShadow,
            color: AppColors.surfaceCream,
            border: Border.all(
              color: AppColors.mutedGold.withValues(alpha: 0.18),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.06,
                  child: Image.asset(
                    textureAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 26, 26, 28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: tarot card image (visually dominant, rounded, soft shadow)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(_kCardImageRadius),
                            boxShadow: _kImageShadow,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(_kCardImageRadius),
                            child: Image.asset(
                              cardImageAsset,
                              width: 128,
                              height: 192,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (cardLabel != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            cardLabel!,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(width: 26),
                    // Right: reading panel (title, text, pill button)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cardTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: 0.15,
                              height: 1.28,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            cardPreview,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.58,
                              fontSize: 15,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 22),
                          Center(
                            child: _PillButton(label: buttonLabel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Ornament top-right: positioned off-edge so only soft corner shows, low opacity
              Positioned(
                top: -14,
                right: -14,
                child: Opacity(
                  opacity: 0.12,
                  child: Image.asset(
                    ornamentAsset,
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Ornament bottom-right: off-edge, very subtle
              Positioned(
                bottom: -10,
                right: -10,
                child: Opacity(
                  opacity: 0.09,
                  child: Image.asset(
                    ornamentAsset,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Numerology: wide panel with large number, texture, ornaments.
class _NumerologyPanel extends StatelessWidget {
  const _NumerologyPanel({
    required this.coreNumber,
    required this.numberTitle,
    required this.numberShort,
    required this.textureAsset,
    required this.ornamentAsset,
    required this.onTap,
  });

  final int coreNumber;
  final String numberTitle;
  final String numberShort;
  final String textureAsset;
  final String ornamentAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kPanelRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kPanelRadius),
            boxShadow: _kPanelShadow,
            color: AppColors.surfaceCream,
            border: Border.all(
              color: AppColors.mutedGold.withValues(alpha: 0.18),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.06,
                  child: Image.asset(
                    textureAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 26, 26, 28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.mutedGold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.mutedGold.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '$coreNumber',
                        style: textTheme.headlineLarge?.copyWith(
                          color: AppColors.mutedGold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 26),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            numberTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: 0.15,
                              height: 1.28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            numberShort,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.58,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Ornament top-left: delicate corner accent (reference)
              Positioned(
                top: -12,
                left: -12,
                child: Opacity(
                  opacity: 0.10,
                  child: Image.asset(
                    ornamentAsset,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Ornament bottom-left: subtle corner
              Positioned(
                bottom: -10,
                left: -10,
                child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(
                    ornamentAsset,
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pill-shaped premium CTA (reference: thin gold outline, light ivory fill).
class _PillButton extends StatelessWidget {
  const _PillButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceIvory,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.35,
          ),
        ),
      ),
    );
  }
}
