import 'package:flutter/material.dart';

import '../../../components/app_sliver_scaffold.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';

class HubPageScaffold extends StatelessWidget {
  const HubPageScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.child,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppSliverScaffold(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.section,
            AppSpacing.page,
            0,
          ),
          sliver: SliverToBoxAdapter(child: child),
        ),
      ],
    );
  }
}

class HubSectionCard extends StatelessWidget {
  const HubSectionCard({
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
    return GlowCard(
      padding: padding,
      gradient: gradient,
      onTap: onTap,
      child: child,
    );
  }
}

class HubMetaChip extends StatelessWidget {
  const HubMetaChip({
    super.key,
    required this.label,
    this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData? icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.successSoft : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: highlighted
              ? AppPalette.primary.withValues(alpha: AppOpacity.quarter)
              : AppPalette.white.withValues(alpha: AppOpacity.xxs),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppIconSize.sm,
              color: highlighted ? AppPalette.primary : AppPalette.textHint,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: highlighted ? AppPalette.primary : AppPalette.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class HubMetricTile extends StatelessWidget {
  const HubMetricTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final IconData? icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.giant),
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.successSoft : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(
          color: highlighted
              ? AppPalette.primary.withValues(alpha: AppOpacity.quarter)
              : AppPalette.white.withValues(alpha: AppOpacity.xxs),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: AppIconSize.lg,
              color: highlighted ? AppPalette.primary : AppPalette.textHint,
            ),
          if (icon != null) const SizedBox(height: AppSpacing.md),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              softWrap: false,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class HubActionButton extends StatelessWidget {
  const HubActionButton({
    super.key,
    required this.label,
    this.icon,
    this.filled = true,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.giant,
          vertical: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: filled ? AppPalette.primary : AppPalette.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(
            color: filled
                ? AppPalette.primary
                : AppPalette.white.withValues(alpha: AppOpacity.xxs),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: AppIconSize.md,
                color: filled ? AppPalette.black : AppPalette.white,
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: filled ? AppPalette.black : AppPalette.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class HubPeopleStack extends StatelessWidget {
  const HubPeopleStack({
    super.key,
    required this.people,
  });

  final List<String> people;

  @override
  Widget build(BuildContext context) {
    final stackWidth = (28.0 + ((people.length - 1) * 18.0).clamp(0.0, 72.0)).toDouble();

    return SizedBox(
      width: stackWidth,
      height: 28,
      child: Stack(
        children: [
          for (var i = 0; i < people.length; i++)
            Positioned(
              left: i * 18,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: AppPalette.surfaceAlt,
                child: Text(
                  people[i],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HubTitleRow extends StatelessWidget {
  const HubTitleRow({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        if (action != null)
          Text(
            action!,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
      ],
    );
  }
}

