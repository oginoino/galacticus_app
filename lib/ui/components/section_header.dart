import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: AppLetterSpacing.tightXs,
                ),
          ),
        ),
        if (actionLabel != null)
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(AppRadius.button),
            child: Padding(
              padding: AppInsets.sectionAction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionLabel!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppPalette.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppPalette.primary,
                    size: AppIconSize.lg,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
