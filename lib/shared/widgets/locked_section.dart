import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'mystic_card.dart';

class LockedSection extends StatelessWidget {
  const LockedSection({
    super.key,
    required this.title,
    required this.message,
    this.ctaLabel = 'Upgrade to unlock',
    this.onTap,
  });

  final String title;
  final String message;
  final String ctaLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: 0.9,
      child: MysticCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lock,
              size: 20,
              color: AppColors.mutedGold,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.mutedGold,
                    ),
                    child: Text(ctaLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
