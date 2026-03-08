import 'package:flutter/material.dart';

import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../theme/app_colors.dart';
import '../card/card_screen.dart';
import '../number/number_screen.dart';
import '../profile/profile_screen.dart';
import '../today/today_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.controller});

  final LocaleController controller;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final locale = widget.controller.current;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TodayScreen(controller: widget.controller),
          CardScreen(controller: widget.controller),
          NumberScreen(controller: widget.controller),
          ProfileScreen(controller: widget.controller),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.mutedGold,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 0,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.today_outlined),
            activeIcon: const Icon(Icons.today),
            label: AppStrings.t(locale, 'nav_today'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.style_outlined),
            activeIcon: const Icon(Icons.style),
            label: AppStrings.t(locale, 'nav_card'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.looks_one_outlined),
            activeIcon: const Icon(Icons.looks_one),
            label: AppStrings.t(locale, 'nav_number'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: AppStrings.t(locale, 'nav_profile'),
          ),
        ],
      ),
    );
  }
}
