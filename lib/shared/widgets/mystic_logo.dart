import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class MysticLogo extends StatelessWidget {
  const MysticLogo({super.key, this.size = 28});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.mutedGold,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Container(
          width: size * 0.18,
          height: size * 0.5,
          decoration: BoxDecoration(
            color: AppColors.mutedGold,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ),
    );
  }
}
