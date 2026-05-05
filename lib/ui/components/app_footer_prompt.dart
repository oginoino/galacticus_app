import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppFooterPrompt extends StatelessWidget {
  const AppFooterPrompt({
    super.key,
    required this.prompt,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          Text(
            prompt,
            style: AppTextStyles.bodyMediumSecondary(context),
          ),
          GestureDetector(
            onTap: onActionTap,
            behavior: HitTestBehavior.opaque,
            child: Text(
              actionLabel,
              style: AppTextStyles.linkAction(context),
            ),
          ),
        ],
      ),
    );
  }
}
