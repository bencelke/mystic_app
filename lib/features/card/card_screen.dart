import 'package:flutter/material.dart';

import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/card_of_day_service.dart';
import '../../models/card_of_day_item.dart';
import '../../shared/widgets/card_reveal_content.dart';
import '../../theme/app_colors.dart';

const Duration _kRevealDuration = Duration(milliseconds: 600);

// Premium reading surface
const double _kCardRadius = 24;
const List<BoxShadow> _kCardShadow = [
  BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 24,
    offset: Offset(0, 8),
  ),
  BoxShadow(
    color: Color(0x06B89B5E),
    blurRadius: 32,
    offset: Offset(0, 12),
  ),
];

class CardScreen extends StatefulWidget {
  const CardScreen({super.key, required this.controller});

  final LocaleController controller;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _revealController;
  late final Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: _kRevealDuration,
    );
    _revealAnimation = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOut,
    );
    _revealController.forward();
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.controller.current;
    final textTheme = Theme.of(context).textTheme;

    final CardOfDayItem card = getCardOfTheDay();
    final String fullText = cardTextForLocale(card, locale);
    final int cardIndex = getCardOfTheDayIndex();
    final String cardImageAsset = cardImageAssetForIndex(cardIndex);
    final String title = AppStrings.t(locale, 'card_of_day_title');
    final String reflectionTitle = AppStrings.t(locale, 'reflection_title');
    final String reflectionQuestion =
        AppStrings.t(locale, 'reflection_question');

    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: canPop
          ? AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => Navigator.of(context).pop(),
                color: AppColors.textPrimary,
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.t(locale, 'card_subtitle'),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 36),
              FadeTransition(
                opacity: _revealAnimation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.97, end: 1.0)
                      .animate(_revealAnimation),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCream,
                      borderRadius: BorderRadius.circular(_kCardRadius),
                      border: Border.all(
                        color: AppColors.mutedGold.withValues(alpha: 0.18),
                        width: 1,
                      ),
                      boxShadow: _kCardShadow,
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
