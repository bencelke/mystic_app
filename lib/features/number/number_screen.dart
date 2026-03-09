import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/numerology_service.dart';
import '../../core/utils/user_profile_local.dart';
import '../../models/numerology_reading.dart';
import '../../shared/widgets/mystic_card.dart';
import '../../theme/app_colors.dart';

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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.mutedGold,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.t(locale, 'numerology_title'),
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.t(locale, 'numerology_setup_need_dob'),
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 28),
                    MysticCard(
                      child: _reading == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
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
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppStrings.t(locale,
                                      'number_screen_placeholder_body'),
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 2,
                                  color: AppColors.mutedGold,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '${_reading!.personalDay}',
                                  style:
                                      textTheme.headlineMedium?.copyWith(
                                    color: AppColors.mutedGold,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  isRu
                                      ? _reading!.titleRu
                                      : _reading!.titleEn,
                                  style:
                                      textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  isRu
                                      ? _reading!.textRu
                                      : _reading!.textEn,
                                  style:
                                      textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.5,
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
}
