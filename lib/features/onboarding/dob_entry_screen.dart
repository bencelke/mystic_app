import 'package:flutter/material.dart';

import '../../core/i18n/app_locale.dart';
import '../../core/i18n/locale_controller.dart';
import '../../core/i18n/strings.dart';
import '../../core/utils/user_profile_local.dart';
import '../../shared/widgets/primary_button.dart';
import '../../theme/app_colors.dart';

class DobEntryScreen extends StatefulWidget {
  const DobEntryScreen({
    super.key,
    required this.controller,
    required this.onComplete,
    required this.onBack,
  });

  final LocaleController controller;
  final VoidCallback onComplete;
  final VoidCallback onBack;

  @override
  State<DobEntryScreen> createState() => _DobEntryScreenState();
}

class _DobEntryScreenState extends State<DobEntryScreen> {
  DateTime? _selectedDate;
  bool _showValidation = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
        _showValidation = false;
      });
    }
  }

  Future<void> _continue() async {
    if (_selectedDate == null) {
      setState(() => _showValidation = true);
      return;
    }
    await setDob(_selectedDate!);
    if (mounted) widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.controller.current;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back_ios_new),
                color: AppColors.textPrimary,
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  minimumSize: const Size(48, 48),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.t(locale, 'dob_entry_title'),
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 48,
                height: 2,
                color: AppColors.mutedGold,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.t(locale, 'dob_entry_subtitle'),
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _showValidation && _selectedDate == null
                          ? AppColors.error
                          : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate != null
                            ? _formatDate(_selectedDate!, locale)
                            : AppStrings.t(locale, 'dob_entry_pick_hint'),
                        style: textTheme.bodyLarge?.copyWith(
                          color: _selectedDate != null
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 20,
                        color: AppColors.mutedGold,
                      ),
                    ],
                  ),
                ),
              ),
              if (_showValidation && _selectedDate == null) ...[
                const SizedBox(height: 8),
                Text(
                  AppStrings.t(locale, 'dob_entry_validation'),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                    height: 1.3,
                  ),
                ),
              ],
              const Spacer(),
              PrimaryButton(
                label: AppStrings.t(locale, 'dob_why_continue'),
                onPressed: _continue,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d, AppLocale locale) {
    const enMonths = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    const ruMonths = [
      'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    final months = locale == AppLocale.ru ? ruMonths : enMonths;
    return locale == AppLocale.ru
        ? '${d.day} ${months[d.month - 1]} ${d.year}'
        : '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}
