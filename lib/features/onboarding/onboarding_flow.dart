import 'package:flutter/material.dart';

import '../../core/i18n/locale_controller.dart';
import 'app_intro_screen.dart';
import 'dob_entry_screen.dart';
import 'dob_why_screen.dart';
import 'language_selection_screen.dart';
import 'onboarding_welcome_screen.dart';

/// Single first-run onboarding sequence. Steps: 0=Language, 1=Welcome, 2=AppIntro, 3=DobWhy, 4=DobEntry → complete.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({
    super.key,
    required this.controller,
    required this.onComplete,
  });

  final LocaleController controller;
  final VoidCallback onComplete;

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _step = 0;

  void _next() {
    setState(() => _step++);
  }

  void _back() {
    if (_step > 0) setState(() => _step--);
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case 0:
        return LanguageSelectionScreen(
          controller: widget.controller,
          onNext: _next,
        );
      case 1:
        return OnboardingWelcomeScreen(
          controller: widget.controller,
          onNext: _next,
          onBack: _back,
        );
      case 2:
        return AppIntroScreen(
          controller: widget.controller,
          onNext: _next,
          onBack: _back,
        );
      case 3:
        return DobWhyScreen(
          controller: widget.controller,
          onNext: _next,
          onBack: _back,
        );
      case 4:
        return DobEntryScreen(
          controller: widget.controller,
          onComplete: widget.onComplete,
          onBack: _back,
        );
      default:
        return LanguageSelectionScreen(
          controller: widget.controller,
          onNext: _next,
        );
    }
  }
}
