import 'package:flutter/material.dart';

import '../../../../domain/quick_access_item.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';
import 'home_dashboard_widgets.dart';

class HomeQuickAccessCard extends StatelessWidget {
  const HomeQuickAccessCard({
    super.key,
    required this.item,
  });

  final QuickAccessItem item;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      height: compact
          ? AppSize.quickAccessCardHeightCompact
          : AppSize.quickAccessCardHeight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.sm),
            width: AppStroke.hairline,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                item.backgroundAsset,
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.stronger),
                      AppPalette.black.withValues(alpha: AppOpacity.overlay),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? AppSpacing.xl : AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: AppLetterSpacing.tightXl,
                            fontSize: compact
                                ? AppFontSize.title
                                : AppFontSize.headingSm,
                          ),
                    ),
                    SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _content(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    final content = item.content;

    switch (item.type) {
      case 'check':
        final weekdays = (content['weekdays'] as List<dynamic>)
            .cast<String>()
            .toList(growable: false);
        final activeDays = (content['activeDays'] as List<dynamic>)
            .cast<bool>()
            .toList(growable: false);
        return [
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final active in activeDays)
                Container(
                  width: AppSpacing.giant,
                  height: AppSpacing.giant,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppPalette.primary
                        : AppPalette.inactiveDot,
                  ),
                  child: active
                      ? const Icon(
                          Icons.check,
                          size: AppFontSize.body,
                          color: AppPalette.black,
                        )
                      : null,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: weekdays
                .map(
                  (label) => Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppPalette.textHint,
                            fontSize: AppFontSize.caption,
                          ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textGlass,
                  fontSize: AppFontSize.body,
                ),
          ),
        ];
      case 'event':
        return [
          Text(
            item.accentLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textNeutral,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            content['detailTitle'] as String,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: AppSpacing.sm,
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                content['progressLabel'] as String,
                style: const TextStyle(color: AppPalette.textNeutralAlt),
              ),
            ],
          ),
        ];
      case 'sports':
        return [
          Text(
            content['headline'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textNeutralAlt,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            content['playersLine'] as String,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textNeutralAlt,
                  fontSize: AppFontSize.body,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            content['scoreLine'] as String,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: AppFontSize.metric,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppPalette.successDark,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              content['statusLabel'] as String,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ];
      case 'chart':
        return [
          const HomeMiniBarChart(),
          const SizedBox(height: AppSpacing.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content['metricValue'] as String,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppPalette.white,
                      fontSize: AppFontSize.metric,
                    ),
              ),
              Text(
                content['metricLabel'] as String,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppPalette.textGlass,
                    ),
              ),
            ],
          ),
        ];
      case 'ranking':
        return [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                content['positionValue'] as String,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFontSize.displaySm,
                    ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content['positionLabel'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppPalette.textGlass,
                            ),
                      ),
                      Text(
                        content['positionDelta'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPalette.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ];
      case 'shooting':
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              content['detailTitle'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPalette.textGlass,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...((content['avatars'] as List<dynamic>).cast<String>()).map(
                (asset) => CircleAvatar(
                  radius: AppSize.quickAccessAvatarRadius,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                width: AppSize.badgeSquare,
                height: AppSize.badgeSquare,
                decoration: BoxDecoration(
                  color: AppPalette.white.withValues(alpha: AppOpacity.soft),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: AppPalette.white.withValues(alpha: AppOpacity.medium),
                    width: AppStroke.hairline,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'clubs':
        return [
          Text(
            content['detailTitle'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textGlass,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...((content['avatars'] as List<dynamic>).cast<String>()).map(
                (asset) => CircleAvatar(
                  radius: AppSize.quickAccessAvatarRadius,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxl),
                  borderRadius: BorderRadius.circular(AppRadius.xxxl),
                ),
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'calendar':
        return [
          Text(
            content['detailTitle'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textCalendarLight,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            content['timeLabel'] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: ((content['chips'] as List<dynamic>).cast<Map<String, dynamic>>())
                .map(
                  (chip) => HomeSportChip(
                    label: chip['label'] as String,
                    highlighted: chip['highlighted'] as bool? ?? false,
                  ),
                )
                .toList(growable: false),
          ),
        ];
      default:
        return [
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textGlass,
                ),
          ),
        ];
    }
  }
}
