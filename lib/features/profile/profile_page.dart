import 'package:flutter/material.dart';

import '../../shared/widgets/mystic_card.dart';
import '../../shared/widgets/section_title.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Profile'),
          const SizedBox(height: 16),
          MysticCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mystic Seeker',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Create an account soon to sync your rituals across devices.',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MysticCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Streak'),
                    SizedBox(height: 4),
                    Text('0 days'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('XP'),
                    SizedBox(height: 4),
                    Text('0'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MysticCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Subscription'),
                SizedBox(height: 8),
                Text(
                  'Mystic Premium is not available yet.\nWhen it unlocks, your advanced spreads and archives will appear here.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
