import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mutedGold,
        brightness: Brightness.light,
        primary: AppColors.mutedGold,
        onPrimary: AppColors.background,
        background: AppColors.background,
        surface: AppColors.card,
      ),
      textTheme: AppText.textTheme,
    );

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.background,
        elevation: 0.5,
        shadowColor: AppColors.textPrimary.withOpacity(0.05),
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
      ),
      cardTheme: base.cardTheme.copyWith(
        color: AppColors.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mutedGold,
          foregroundColor: AppColors.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          textStyle: AppText.textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
