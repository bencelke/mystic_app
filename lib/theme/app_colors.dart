import 'package:flutter/material.dart';

/// 🔒 DESIGN LOCK: DO NOT MODIFY COLORS WITHOUT EXPLICIT APPROVAL.
/// All colors for Mystic must come ONLY from this file.
/// No hard-coded Color(...) or Colors.* allowed anywhere else.
class AppColors {
  AppColors._();

  // Core
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color textPrimary = Color(0xFF000000); // Black
  static const Color textSecondary = Color(0xFF444444);

  // Accent
  static const Color mutedGold = Color(0xFFB89B5E);

  // Surfaces
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E5E5);

  // States
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFC62828);

  // Utility
  static const Color transparent = Color(0x00000000);

  // Aliases
  static const Color white = background;
  static const Color black = textPrimary;
}
