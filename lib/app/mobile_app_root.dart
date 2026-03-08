import 'package:flutter/material.dart';

import '../core/i18n/locale_controller.dart';
import '../core/storage/onboarding_storage.dart';
import '../features/home/home_shell.dart';
import '../features/onboarding/onboarding_flow.dart';
import '../theme/app_colors.dart';
import '../shared/widgets/mystic_logo.dart';

class MobileAppRoot extends StatefulWidget {
  const MobileAppRoot({super.key, required this.controller});

  final LocaleController controller;

  @override
  State<MobileAppRoot> createState() => _MobileAppRootState();
}

class _MobileAppRootState extends State<MobileAppRoot> {
  bool _isReady = false;
  bool _onboardingComplete = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final complete = await isOnboardingComplete();
    final savedLang = await getSavedLanguage();
    if (!mounted) return;
    if (savedLang != null) {
      widget.controller.switchTo(savedLang);
    }
    setState(() {
      _isReady = true;
      _onboardingComplete = complete;
    });
  }

  Future<void> _completeOnboarding() async {
    await setOnboardingComplete(true);
    if (!mounted) return;
    setState(() => _onboardingComplete = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return _LoadingSplash();
    }
    if (_onboardingComplete) {
      return HomeShell(controller: widget.controller);
    }
    return OnboardingFlow(
      controller: widget.controller,
      onComplete: _completeOnboarding,
    );
  }
}

class _LoadingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
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
    );
  }
}
