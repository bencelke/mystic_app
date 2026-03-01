import 'package:flutter/material.dart';

import '../../shared/widgets/app_scaffold.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel();

    return AppScaffold(
      title: 'Mystic',
      child: Center(
        child: Text(viewModel.message),
      ),
    );
  }
}
