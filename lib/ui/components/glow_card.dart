import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GlowCard extends StatelessWidget {
  const GlowCard({
    super.key,
    required this.child,
    this.padding = AppInsets.glowCard,
    this.gradient,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? AppPalette.card : null,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: AppPalette.border,
          width: AppStroke.hairline,
        ),
        boxShadow: [
          BoxShadow(
            color: AppPalette.black.withValues(alpha: AppOpacity.strong),
            blurRadius: AppShadow.cardBlur,
            offset: const Offset(0, AppShadow.cardOffsetY),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.card),
      onTap: onTap,
      child: content,
    );
  }
}
