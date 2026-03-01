import 'package:flutter/material.dart';

import '../core/i18n/app_locale.dart';
import '../core/i18n/locale_controller.dart';
import '../core/i18n/strings.dart';
import '../features/today/card_of_the_day_page.dart';
import '../shared/widgets/auth/login_dialog.dart';
import '../shared/widgets/mystic_logo.dart';
import '../theme/app_colors.dart';

class WebAppShell extends StatefulWidget {
  const WebAppShell({super.key, required this.controller});

  final LocaleController controller;

  @override
  State<WebAppShell> createState() => _WebAppShellState();
}

class _WebAppShellState extends State<WebAppShell> {
  String _currentSection = 'today';

  void _onSelectSection(String section) {
    setState(() {
      _currentSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Scaffold(
      body: Column(
        children: [
          _TopBar(
            controller: controller,
            currentSection: _currentSection,
            onSelectSection: _onSelectSection,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 900;

                if (isNarrow) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 980),
                      child: CardOfTheDayPage(
                        controller: controller,
                        currentSection: _currentSection,
                      ),
                    ),
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Sidebar(controller: controller),
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 980),
                          child: CardOfTheDayPage(
                            controller: controller,
                            currentSection: _currentSection,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.controller,
    required this.currentSection,
    required this.onSelectSection,
  });

  final LocaleController controller;
  final String currentSection;
  final ValueChanged<String> onSelectSection;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = controller.current;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          const MysticLogo(),
          const SizedBox(width: 12),
          Text(
            AppStrings.t(locale, 'app_name'),
            style: textTheme.titleMedium,
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TopNavLink(
                label: AppStrings.t(locale, 'nav_today'),
                isActive: currentSection == 'today',
                onTap: () => onSelectSection('today'),
              ),
              const SizedBox(width: 16),
              _TopNavLink(
                label: AppStrings.t(locale, 'nav_archive'),
                isActive: currentSection == 'archive',
                isLocked: true,
                onTap: () => onSelectSection('archive'),
              ),
              const SizedBox(width: 16),
              _TopNavLink(
                label: AppStrings.t(locale, 'nav_about'),
                isActive: currentSection == 'about',
                onTap: () => onSelectSection('about'),
              ),
            ],
          ),
          const Spacer(),
          _LocaleToggle(controller: controller),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (_) => LoginDialog(controller: controller),
              );
            },
            child: Text(AppStrings.t(locale, 'login')),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.t(locale, 'upgrade_toast')),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mutedGold,
              foregroundColor: AppColors.background,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              minimumSize: const Size(0, 0),
            ),
            child: Text(AppStrings.t(locale, 'upgrade')),
          ),
        ],
      ),
    );
  }
}

class _LocaleToggle extends StatelessWidget {
  const _LocaleToggle({required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final locale = controller.current;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => controller.switchTo(AppLocale.en),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              'EN',
              style: textStyle?.copyWith(
                color: locale == AppLocale.en
                    ? AppColors.mutedGold
                    : AppColors.textPrimary.withOpacity(0.6),
                fontWeight:
                    locale == AppLocale.en ? FontWeight.w600 : null,
              ),
            ),
          ),
        ),
        Text(
          ' | ',
          style: textStyle?.copyWith(
            color: AppColors.textPrimary.withOpacity(0.5),
          ),
        ),
        InkWell(
          onTap: () => controller.switchTo(AppLocale.ru),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              'RU',
              style: textStyle?.copyWith(
                color: locale == AppLocale.ru
                    ? AppColors.mutedGold
                    : AppColors.textPrimary.withOpacity(0.6),
                fontWeight:
                    locale == AppLocale.ru ? FontWeight.w600 : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopNavLink extends StatelessWidget {
  const _TopNavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isLocked = false,
  });

  final String label;
  final bool isActive;
  final bool isLocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? AppColors.textPrimary : AppColors.textPrimary.withOpacity(0.6);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
              ),
            ),
            if (isLocked) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.lock,
                size: 14,
                color: color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = controller.current;

    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.border),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.t(locale, 'sidebar_today'),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _SidebarItem(
            label: AppStrings.t(locale, 'sidebar_card_of_day'),
            isActive: true,
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            label: AppStrings.t(locale, 'sidebar_archive'),
            isLocked: true,
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            label: AppStrings.t(locale, 'sidebar_profile'),
            isLocked: true,
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.label,
    this.isActive = false,
    this.isLocked = false,
  });

  final String label;
  final bool isActive;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? AppColors.textPrimary : AppColors.textPrimary.withOpacity(0.7);

    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? AppColors.mutedGold : AppColors.background,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(color: color),
              ),
              if (isLocked) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.lock,
                  size: 14,
                  color: color,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
