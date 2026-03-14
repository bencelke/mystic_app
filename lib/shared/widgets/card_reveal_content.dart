import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Premium layered card reveal content: texture, image, ornament, title, meaning, reflection.
/// Used on the full Card of the Day screen with optional reveal animation.
class CardRevealContent extends StatelessWidget {
  const CardRevealContent({
    super.key,
    required this.cardImageAsset,
    required this.title,
    required this.meaningText,
    required this.reflectionTitle,
    required this.reflectionQuestion,
    this.textureAsset,
    this.ornamentAsset,
  });

  final String cardImageAsset;
  final String title;
  final String meaningText;
  final String reflectionTitle;
  final String reflectionQuestion;
  final String? textureAsset;
  final String? ornamentAsset;

  static const String _defaultTexture =
      'assets/textures/web-texture/lucid-origin_paper_texture__result.webp';
  static const String _defaultOrnament =
      'assets/ornaments/web-ornament/lucid-ornament.webp';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final texture = textureAsset ?? _defaultTexture;
    final ornament = ornamentAsset ?? _defaultOrnament;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Texture only inside card (clipped to card bounds)
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                texture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Layer 2–6: content column (parent MysticCard provides padding)
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image: fixed aspect ratio to avoid stretching
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textPrimary.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Image.asset(
                        cardImageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 48,
                height: 2,
                color: AppColors.mutedGold,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                meaningText,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              // Reflection prompt area
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.mutedGold.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reflectionTitle,
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.mutedGold,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      reflectionQuestion,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.45,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        // Ornament overlay
        Positioned(
          top: -6,
          right: 8,
          child: Opacity(
            opacity: 0.4,
            child: Image.asset(
              ornament,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
