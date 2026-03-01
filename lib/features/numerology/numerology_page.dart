import 'package:flutter/material.dart';

import '../../shared/widgets/mystic_card.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/section_title.dart';

class NumerologyPage extends StatelessWidget {
  const NumerologyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Numerology'),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: 'Birthdate',
              hintText: 'YYYY-MM-DD',
            ),
          ),
          const SizedBox(height: 16),
          const PrimaryButton(
            label: 'Calculate',
            onPressed: null,
          ),
          const SizedBox(height: 24),
          MysticCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Life Path',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '7',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Introspective, intuitive, and guided by quiet wisdom.',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MysticCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Destiny',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '3',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Expression, creativity, and elegant self-expression in all you do.',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
