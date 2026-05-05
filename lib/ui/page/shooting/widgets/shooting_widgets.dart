import 'package:flutter/material.dart';

import '../../../../domain/shot_item.dart';
import '../../../theme/app_theme.dart';

class ShootingModeCard extends StatelessWidget {
  const ShootingModeCard({
    super.key,
    required this.label,
    required this.helpTitle,
    required this.helpText,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final String helpTitle;
  final String helpText;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.giant),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppFontSize.titleLg,
                      ),
                ),
              ),
              Switch.adaptive(
                value: enabled,
                onChanged: onChanged,
                activeThumbColor: AppPalette.primary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            helpTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w600,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            helpText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.bodyLg,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

class ShotsGrid extends StatelessWidget {
  const ShotsGrid({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final List<ShotItem> items;
  final ValueChanged<ShotItem> onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.lg,
        mainAxisSpacing: AppSpacing.lg,
        childAspectRatio: 0.78,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => ShotCard(
        item: items[index],
        onTap: () => onItemTap(items[index]),
      ),
    );
  }
}

class ShotCard extends StatelessWidget {
  const ShotCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final ShotItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item.imageAsset, fit: BoxFit.cover),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppPalette.black.withValues(alpha: AppOpacity.scrim),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppSpacing.lg,
              left: AppSpacing.lg,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: AppPalette.black.withValues(alpha: AppOpacity.overlay),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  item.dateLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w600,
                        fontSize: AppFontSize.label,
                        letterSpacing: AppLetterSpacing.wideSm,
                      ),
                ),
              ),
            ),
            if (item.durationLabel != null)
              Positioned(
                top: AppSpacing.lg,
                right: AppSpacing.lg,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    item.durationLabel!,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppPalette.black,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.label,
                        ),
                  ),
                ),
              ),
            Positioned(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              bottom: AppSpacing.lg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.sportLabel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppPalette.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.bodyLg,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    item.courtLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodySm,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
