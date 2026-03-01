import 'package:flutter/material.dart';

import '../../../core/i18n/locale_controller.dart';
import '../../../core/i18n/strings.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key, required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final locale = controller.current;

    return AlertDialog(
      title: Text(AppStrings.t(locale, 'welcome_back')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: AppStrings.t(locale, 'email'),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: AppStrings.t(locale, 'password'),
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.t(locale, 'create_account_toast')),
              ),
            );
          },
          child: Text(AppStrings.t(locale, 'create_account')),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.t(locale, 'logged_in_demo_toast')),
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text(AppStrings.t(locale, 'log_in_button')),
        ),
      ],
    );
  }
}
