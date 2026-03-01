import 'package:flutter/material.dart';

import '../../shared/widgets/mystic_card.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/section_title.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Today'),
          const SizedBox(height: 16),
          MysticCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Rune',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'ᚨ',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'A quiet sign of new beginnings and subtle shifts in your path today.',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const PrimaryButton(
            label: 'Reveal details',
            onPressed: null,
          ),
          const SizedBox(height: 12),
          const MysticCard(
            child: Text(
              'Details are currently locked.\nPremium insights will be revealed here soon.',
            ),
          ),
        ],
      ),
    );
  }
}
