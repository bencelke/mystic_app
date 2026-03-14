import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/numerology_service.dart';
import '../../core/utils/user_profile_local.dart';
import '../../models/numerology_reading.dart';
import '../../theme/app_colors.dart';

const String _kTextureAsset =
    'assets/textures/web-texture/lucid-origin_paper_texture__result.webp';

const double _kPanelRadius = 22;
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

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key, required this.controller});

  final LocaleController controller;

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  NumerologyReading? _reading;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final dob = await getDob();
    final now = DateTime.now();
    if (!mounted) return;
    if (dob != null) {
      final reading = buildReading(dob, now, widget.controller.current);
      setState(() {
        _reading = reading;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.controller.current;
    final textTheme = Theme.of(context).textTheme;
    final bool isRu = locale == AppLocale.ru;
    final bool canPop = Navigator.canPop(context);

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
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.mutedGold,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.t(locale, 'numerology_title'),
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.t(locale, 'numerology_setup_need_dob'),
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _PremiumNumerologyPanel(
                      textureAsset: _kTextureAsset,
                      child: _reading == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 2,
                                  color: AppColors.mutedGold,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppStrings.t(locale,
                                      'number_screen_placeholder_title'),
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                    letterSpacing: 0.15,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppStrings.t(locale,
                                      'number_screen_placeholder_body'),
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.58,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.mutedGold
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.mutedGold
                                          .withValues(alpha: 0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    '${_reading!.personalDay}',
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
                                        isRu
                                            ? _reading!.titleRu
                                            : _reading!.titleEn,
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                          letterSpacing: 0.15,
                                          height: 1.28,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        isRu
                                            ? _reading!.textRu
                                            : _reading!.textEn,
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
                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }
}

/// Premium panel with textured surface (matches Today/Card panel system).
class _PremiumNumerologyPanel extends StatelessWidget {
  const _PremiumNumerologyPanel({
    required this.textureAsset,
    required this.child,
  });

  final String textureAsset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: child,
          ),
        ],
      ),
    );
  }
}
