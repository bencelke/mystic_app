import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../shared/widgets/mystic_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) widget.onNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MysticLogo(size: 48),
              const SizedBox(height: 24),
              Container(
                width: 32,
                height: 2,
                color: AppColors.mutedGold,
              ),
              const SizedBox(height: 16),
              Text(
                'Mystic',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
