import 'package:flutter/material.dart';

import '../../domain/checkin_overlay.dart';
import '../theme/app_theme.dart';

class CheckinOverlayView extends StatelessWidget {
  const CheckinOverlayView({
    super.key,
    required this.overlay,
    this.compact = false,
  });

  final CheckinOverlay overlay;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (overlay.sportLabel != null || overlay.timeLabel != null) {
      children.add(_TopRow(overlay: overlay));
      children.add(const SizedBox(height: AppSpacing.lg));
    }

    if (overlay.headline != null) {
      children.add(
        Text(
          overlay.headline!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w700,
                fontSize:
                    compact ? AppFontSize.headingSm : AppFontSize.heading,
                height: 1,
              ),
        ),
      );
    }

    if (overlay.subheadline != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: AppSpacing.sm));
      }
      children.add(
        Text(
          overlay.subheadline!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textMuted,
                fontSize: compact ? AppFontSize.body : AppFontSize.bodyLg,
                height: 1.2,
              ),
        ),
      );
    }

    if (overlay.type == 'score' &&
        overlay.scoreHome != null &&
        overlay.scoreAway != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: AppSpacing.giant));
      }
      children.add(_Scoreboard(overlay: overlay, compact: compact));
    }

    if (overlay.type == 'favorite' && overlay.achievementLabel != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: AppSpacing.lg));
      }
      children.add(_AchievementChip(label: overlay.achievementLabel!));
    }

    if (overlay.metrics.isNotEmpty) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: AppSpacing.giant));
      }
      children.add(_MetricsRow(metrics: overlay.metrics, compact: compact));
    }

    if (overlay.locationLabel != null || overlay.weatherLabel != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: AppSpacing.giant));
      }
      children.add(_FooterRow(overlay: overlay));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow({required this.overlay});

  final CheckinOverlay overlay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (overlay.sportLabel != null)
          _OverlayBadge(
            label: overlay.sportLabel!,
            background: AppPalette.primary,
            foreground: AppPalette.black,
          ),
        const Spacer(),
        if (overlay.timeLabel != null)
          _OverlayBadge(
            label: overlay.timeLabel!,
            background: AppPalette.surfaceAlt
                .withValues(alpha: AppOpacity.overlayStrong),
            foreground: AppPalette.white,
          ),
      ],
    );
  }
}

class _OverlayBadge extends StatelessWidget {
  const _OverlayBadge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.bodySm,
              letterSpacing: AppLetterSpacing.wideSm,
            ),
      ),
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({required this.metrics, required this.compact});

  final List<CheckinOverlayMetric> metrics;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: metrics
          .map(
            (metric) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: metric == metrics.last ? 0 : AppSpacing.md,
                ),
                child: _MetricTile(metric: metric, compact: compact),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.metric, required this.compact});

  final CheckinOverlayMetric metric;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.overlay),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            metric.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w700,
                  fontSize: compact ? AppFontSize.title : AppFontSize.titleLg,
                  height: 1,
                ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            metric.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.label,
                  letterSpacing: AppLetterSpacing.wideSm,
                ),
          ),
        ],
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  const _Scoreboard({required this.overlay, required this.compact});

  final CheckinOverlay overlay;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.giant,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.overlay),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ScoreSide(
              team: overlay.teamHome,
              score: overlay.scoreHome!,
              compact: compact,
              align: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              ':',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppPalette.textMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: compact
                        ? AppFontSize.metric
                        : AppFontSize.displaySm,
                  ),
            ),
          ),
          Expanded(
            child: _ScoreSide(
              team: overlay.teamAway,
              score: overlay.scoreAway!,
              compact: compact,
              align: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreSide extends StatelessWidget {
  const _ScoreSide({
    required this.team,
    required this.score,
    required this.compact,
    required this.align,
  });

  final String? team;
  final String score;
  final bool compact;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        if (team != null)
          Text(
            team!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: align,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.label,
                  letterSpacing: AppLetterSpacing.wideSm,
                ),
          ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          score,
          textAlign: align,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w800,
                fontSize:
                    compact ? AppFontSize.metric : AppFontSize.displaySm,
                height: 1,
              ),
        ),
      ],
    );
  }
}

class _AchievementChip extends StatelessWidget {
  const _AchievementChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppPalette.primary.withValues(alpha: AppOpacity.medium),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppPalette.primary,
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.favorite_rounded,
            color: AppPalette.primary,
            size: AppIconSize.md,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.bodySm,
                  letterSpacing: AppLetterSpacing.wideSm,
                ),
          ),
        ],
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({required this.overlay});

  final CheckinOverlay overlay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (overlay.locationLabel != null) ...[
          const Icon(
            Icons.location_on_outlined,
            color: AppPalette.white,
            size: AppIconSize.md,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              overlay.locationLabel!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.white,
                    fontSize: AppFontSize.body,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
        if (overlay.locationLabel != null && overlay.weatherLabel != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(
              '·',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textMuted,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ),
        if (overlay.weatherLabel != null)
          Flexible(
            child: Text(
              overlay.weatherLabel!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textMuted,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ),
      ],
    );
  }
}
