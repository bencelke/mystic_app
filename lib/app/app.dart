import 'package:flutter/material.dart';

import '../core/i18n/app_locale.dart';
import '../core/i18n/locale_controller.dart';
import '../core/routing/app_router.dart';
import '../theme/app_theme.dart';
import 'mobile_app_root.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final LocaleController localeController = LocaleController();

  @override
  void dispose() {
    localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: localeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Mystic',
          theme: AppTheme.light(),
          locale: localeController.current.toLocale(),
          home: MobileAppRoot(controller: localeController),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
