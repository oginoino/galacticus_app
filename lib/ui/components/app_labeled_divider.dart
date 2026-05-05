import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppLabeledDivider extends StatelessWidget {
  const AppLabeledDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final lineColor = AppPalette.white.withValues(alpha: AppOpacity.xxs);

    return Row(
      children: [
        Expanded(
          child: Divider(color: lineColor, height: AppStroke.hairline),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Text(
            label,
            style: AppTextStyles.dividerLabel(context),
          ),
        ),
        Expanded(
          child: Divider(color: lineColor, height: AppStroke.hairline),
        ),
      ],
    );
  }
}
