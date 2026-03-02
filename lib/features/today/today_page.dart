import 'package:flutter/material.dart';

import '../../config/dev_flags.dart';
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
                  'Card of the Day',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'A daily symbol to guide your focus.',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Reveal details',
            onPressed: kDevUnlockAll
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Coming soon'),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(height: 12),
          if (!kDevUnlockAll)
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
