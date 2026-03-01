import 'package:flutter/material.dart';

import '../../shared/widgets/mystic_card.dart';
import '../../shared/widgets/section_title.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SectionTitle('Library'),
          SizedBox(height: 16),
          MysticCard(
            child: Text(
              'Premium library coming soon.\nYour curated rituals, spreads, and teachings will live here.',
            ),
          ),
        ],
      ),
    );
  }
}
