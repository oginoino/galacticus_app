import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../domain/progress_activity_ring_metric.dart';
import '../../../../domain/progress_chart_point.dart';
import '../../../../domain/progress_filter_option.dart';
import '../../../../domain/progress_match_result.dart';
import '../../../../domain/progress_overview.dart';
import '../../../../domain/progress_skill_metric.dart';
import '../../../../domain/progress_stat_card.dart';
import '../../../../domain/progress_time_range_option.dart';
import '../../../../domain/progress_weekly_lesson_bar.dart';
import '../../../theme/app_theme.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({
    super.key,
    required this.title,
    required this.filters,
    required this.timeRanges,
    required this.selectedFilterId,
    required this.selectedTimeRangeId,
    required this.onBackTap,
    required this.onShareTap,
    required this.onFilterTap,
    required this.onTimeRangeTap,
  });

  final String title;
  final List<ProgressFilterOption> filters;
  final List<ProgressTimeRangeOption> timeRanges;
  final String selectedFilterId;
  final String selectedTimeRangeId;
  final VoidCallback onBackTap;
  final VoidCallback onShareTap;
  final ValueChanged<String> onFilterTap;
  final ValueChanged<String> onTimeRangeTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSize.rankingHeaderLeadingInset,
        topInset + AppSpacing.page,
        AppSpacing.page,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _HeaderActionButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: onBackTap,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.heading,
                    ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _HeaderActionButton(
                  icon: Icons.share_outlined,
                  onTap: onShareTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _SegmentedGroup(
                  items: filters
                      .map(
                        (item) => _ChipItem(
                          id: item.id,
                          label: item.label,
                          selected: item.id == selectedFilterId,
                        ),
                      )
                      .toList(growable: false),
                  compact: false,
                  onTap: onFilterTap,
                ),
                const SizedBox(width: AppSpacing.xl),
                _SegmentedGroup(
                  items: timeRanges
                      .map(
                        (item) => _ChipItem(
                          id: item.id,
                          label: item.label,
                          selected: item.id == selectedTimeRangeId,
                        ),
                      )
                      .toList(growable: false),
                  compact: true,
                  onTap: onTimeRangeTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScoreCard extends StatelessWidget {
  const ProgressScoreCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    final progress = overview.levelProgressTarget == 0
        ? 0.0
        : overview.levelProgressValue / overview.levelProgressTarget;
    final currentLevel = _extractLevelNumber(overview.levelLabel);
    final nextLevel = currentLevel == null ? null : currentLevel + 1;

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overview.scoreTitle.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppPalette.textHint,
                            fontWeight: FontWeight.w700,
                            letterSpacing: AppLetterSpacing.wideSm,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          overview.scoreValue,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: AppLetterSpacing.tightLg,
                                fontSize: AppFontSize.metricLg,
                              ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: Text(
                            overview.scoreDelta,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppPalette.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      overview.levelLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppPalette.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    overview.nextLevelLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppPalette.textHint,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    overview.nextLevelRemainingLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.giant),
          if (currentLevel != null || nextLevel != null)
            Row(
              children: [
                Text(
                  currentLevel == null ? '' : 'Nv. $currentLevel',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.textHint,
                      ),
                ),
                const Spacer(),
                Text(
                  nextLevel == null ? '' : 'Nv. $nextLevel',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.textHint,
                      ),
                ),
              ],
            ),
          if (currentLevel != null || nextLevel != null)
            const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: progress.clamp(0, 1).toDouble(),
              minHeight: 6,
              backgroundColor: AppPalette.white.withValues(alpha: AppOpacity.xxl),
              valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${overview.levelProgressValue} / ${overview.levelProgressTarget}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.textMuted,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressStatsGrid extends StatelessWidget {
  const ProgressStatsGrid({
    super.key,
    required this.items,
  });

  final List<ProgressStatCard> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (AppSpacing.md * 3)) / 4;
        final childAspectRatio = cardWidth / 86;

        return GridView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) => _ProgressMiniStatCard(item: items[index]),
        );
      },
    );
  }
}

class ProgressPointsChartCard extends StatelessWidget {
  const ProgressPointsChartCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.pointsSectionTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            overview.pointsSectionSubtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.textHint,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _LegendDot(
                color: AppPalette.primary,
                label: overview.uiLabels.pointsChartYouLabel,
              ),
              const SizedBox(width: AppSpacing.giant),
              _LegendDot(
                color: AppPalette.textHint,
                label: overview.uiLabels.pointsChartAverageLabel,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 142,
            child: CustomPaint(
              painter: _ProgressLineChartPainter(
                items: overview.pointsChart,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: overview.pointsChart
                .map(
                  (point) => Expanded(
                    child: Text(
                      point.label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppPalette.textAxis,
                          ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class ProgressActivityRingsCard extends StatelessWidget {
  const ProgressActivityRingsCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  overview.activitySectionTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                overview.uiLabels.activityTodayLabel,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.textHint,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: overview.activityRings
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: item == overview.activityRings.last ? 0 : AppSpacing.sm,
                      ),
                      child: _ProgressRingMetricWidget(item: item),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class ProgressSkillMapCard extends StatelessWidget {
  const ProgressSkillMapCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.skillMapTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              Expanded(
                child: Text(
                  overview.skillMapSportLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.textHint,
                      ),
                ),
              ),
              Text(
                '↗ ${overview.skillMapScoreLabel}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 178,
            child: CustomPaint(
              painter: _SkillRadarPainter(
                items: overview.skillMetrics,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressConsistencyCard extends StatelessWidget {
  const ProgressConsistencyCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  overview.consistencyTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const _HeatLegend(),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            overview.consistencySubtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.textHint,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Column(
            children: overview.consistencyHeatmap
                .map(
                  (week) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      children: week
                          .map(
                            (value) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: _heatmapColor(value),
                                      borderRadius: BorderRadius.circular(AppRadius.xs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: overview.consistencySummary
                .map(
                  (item) => Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppPalette.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppPalette.textMuted,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class ProgressTennisStatsCard extends StatelessWidget {
  const ProgressTennisStatsCard({
    super.key,
    required this.overview,
    required this.onTap,
  });

  final ProgressOverview overview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        children: [
          _ProgressSectionHeader(
            title: overview.tennisStatsTitle,
            actionLabel: overview.uiLabels.tennisStatsActionLabel,
            onActionTap: onTap,
          ),
          const SizedBox(height: AppSpacing.md),
          GridView.builder(
            itemCount: overview.tennisStats.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.26,
            ),
            itemBuilder: (context, index) {
              final item = overview.tennisStats[index];
              return _ProgressLargeStatCard(item: item);
            },
          ),
        ],
      ),
    );
  }
}

class ProgressMatchesCard extends StatelessWidget {
  const ProgressMatchesCard({
    super.key,
    required this.overview,
    required this.onTap,
  });

  final ProgressOverview overview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        children: [
          _ProgressSectionHeader(
            title: overview.matchesTitle,
            actionLabel: overview.uiLabels.matchesActionLabel,
            onActionTap: onTap,
          ),
          const SizedBox(height: AppSpacing.md),
          ...overview.matches.map(
            (item) => Padding(
              padding: EdgeInsets.only(
                bottom: item == overview.matches.last ? 0 : AppSpacing.md,
              ),
              child: _MatchRow(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressLessonsCard extends StatelessWidget {
  const ProgressLessonsCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    final maxValue = overview.lessonsBars.fold<double>(
      0,
      (current, item) => math.max(current, math.max(item.groupValue, item.privateValue)),
    );

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.lessonsTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            overview.lessonsSubtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.textHint,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _LegendDot(
                color: AppPalette.primary,
                label: overview.uiLabels.lessonsGroupLabel,
              ),
              const SizedBox(width: AppSpacing.lg),
              _LegendDot(
                color: AppPalette.textHint,
                label: overview.uiLabels.lessonsPrivateLabel,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 128,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: overview.lessonsBars
                  .map(
                    (item) => Expanded(
                      child: _LessonsBarPair(
                        item: item,
                        maxValue: maxValue == 0 ? 1 : maxValue,
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressRecordsCard extends StatelessWidget {
  const ProgressRecordsCard({
    super.key,
    required this.overview,
  });

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              overview.recordsTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: AppInsets.cardPaddingLg,
            decoration: BoxDecoration(
              color: AppPalette.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: AppPalette.primary.withValues(alpha: AppOpacity.quarter),
                width: AppStroke.hairline,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _RecordsMetric(item: overview.records[0])),
                    const SizedBox(width: AppSpacing.giant),
                    Expanded(child: _RecordsMetric(item: overview.records[1])),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.giant),
                  child: Container(
                    height: AppStroke.hairline,
                    color: AppPalette.primary.withValues(alpha: AppOpacity.xxl),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: _RecordsMetric(item: overview.records[2])),
                    const SizedBox(width: AppSpacing.giant),
                    Expanded(child: _RecordsMetric(item: overview.records[3])),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedGroup extends StatelessWidget {
  const _SegmentedGroup({
    required this.items,
    required this.onTap,
    this.compact = false,
  });

  final List<_ChipItem> items;
  final ValueChanged<String> onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (item) => Padding(
                padding: EdgeInsets.only(
                  right: item == items.last ? 0 : AppSpacing.sm,
                ),
                child: InkWell(
                  onTap: () => onTap(item.id),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    height: compact ? 34 : 36,
                    padding: EdgeInsets.symmetric(
                      horizontal: compact ? AppSpacing.xl : AppSpacing.giant,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: item.selected ? AppPalette.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Center(
                      child: Text(
                        item.label,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: item.selected ? AppPalette.black : AppPalette.white,
                              fontWeight: item.selected ? FontWeight.w700 : FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        width: AppSize.rankingTopAction,
        height: AppSize.rankingTopAction,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppPalette.surfaceAlt,
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Icon(
          icon,
          color: AppPalette.white,
          size: icon == Icons.share_outlined ? AppIconSize.xxl : AppIconSize.huge,
        ),
      ),
    );
  }
}

class _ProgressMiniStatCard extends StatelessWidget {
  const _ProgressMiniStatCard({
    required this.item,
  });

  final ProgressStatCard item;

  @override
  Widget build(BuildContext context) {
    final accentColor = AppPalette.primary;

    return Container(
      padding: AppInsets.cardPaddingMd,
      decoration: BoxDecoration(
        color: item.highlighted ? AppPalette.successDark : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: item.highlighted
              ? AppPalette.primary.withValues(alpha: AppOpacity.quarter)
              : AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _iconForMiniStat(item.title),
                size: AppIconSize.sm,
                color: item.highlighted ? AppPalette.primary : AppPalette.textHint,
              ),
              const Spacer(),
              Text(
                item.delta,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.caption,
                      height: 1,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFontSize.titleSm,
                      height: 1,
                    ),
              ),
              const SizedBox(height: 1),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppPalette.textMuted,
                      fontSize: AppFontSize.caption,
                      height: 1,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressLargeStatCard extends StatelessWidget {
  const _ProgressLargeStatCard({
    required this.item,
  });

  final ProgressStatCard item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.cardPaddingLg,
      decoration: BoxDecoration(
        color: item.highlighted ? AppPalette.successSoft : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: item.highlighted
              ? AppPalette.primary.withValues(alpha: AppOpacity.quarter)
              : AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _iconForLargeStat(item.title),
                size: AppIconSize.lg,
                color: item.highlighted ? AppPalette.primary : AppPalette.textHint,
              ),
              const Spacer(),
              Text(
                item.delta,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            item.value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.textMuted,
                ),
          ),
          if (item.subtitle != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppPalette.textHint,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgressRingMetricWidget extends StatelessWidget {
  const _ProgressRingMetricWidget({
    required this.item,
  });

  final ProgressActivityRingMetric item;

  @override
  Widget build(BuildContext context) {
    final ringColor = _hexToColor(item.colorHex);

    return Column(
      children: [
        SizedBox(
          width: 62,
          height: 62,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size.square(62),
                painter: _RingPainter(
                  progress: item.progress,
                  color: ringColor,
                ),
              ),
              Text(
                item.value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.bodySm,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          item.title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.bodySm,
              ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          item.targetLabel,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppPalette.textHint,
                fontSize: AppFontSize.caption,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}


class _MatchRow extends StatelessWidget {
  const _MatchRow({
    required this.item,
  });

  final ProgressMatchResult item;

  @override
  Widget build(BuildContext context) {
    final positive = item.result == 'V';

    return Container(
      padding: AppInsets.cardPaddingMd,
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: (positive ? AppPalette.primary : Colors.redAccent)
                  .withValues(alpha: AppOpacity.accent),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            alignment: Alignment.center,
            child: Text(
              item.result,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: positive ? AppPalette.black : AppPalette.white,
                    fontWeight: FontWeight.w800,
                    fontSize: AppFontSize.caption,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.opponent,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppFontSize.body,
                      ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  item.dateLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.textHint,
                        fontSize: AppFontSize.caption,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            item.score,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.body,
                ),
          ),
        ],
      ),
    );
  }
}

class _LessonsBarPair extends StatelessWidget {
  const _LessonsBarPair({
    required this.item,
    required this.maxValue,
  });

  final ProgressWeeklyLessonBar item;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    final groupHeight = (item.groupValue / maxValue) * 82;
    final privateHeight = (item.privateValue / maxValue) * 82;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _LessonBar(
                height: groupHeight.clamp(12, 82).toDouble(),
                color: AppPalette.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              _LessonBar(
                height: privateHeight.clamp(12, 82).toDouble(),
                color: AppPalette.textHint,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          item.label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppPalette.textAxis,
              ),
        ),
      ],
    );
  }
}

class _LessonBar extends StatelessWidget {
  const _LessonBar({
    required this.height,
    required this.color,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    );
  }
}

class _RecordsMetric extends StatelessWidget {
  const _RecordsMetric({
    required this.item,
  });

  final ProgressStatCard item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppPalette.textHint,
                fontWeight: FontWeight.w700,
                letterSpacing: AppLetterSpacing.wideSm,
              ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          item.value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          item.delta,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppPalette.textMuted,
              ),
        ),
      ],
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.cardPaddingLg,
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: child,
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppPalette.textMuted,
              ),
        ),
      ],
    );
  }
}

class _ProgressSectionHeader extends StatelessWidget {
  const _ProgressSectionHeader({
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        if (actionLabel != null)
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(AppRadius.button),
            child: Padding(
              padding: AppInsets.sectionAction,
              child: Text(
                actionLabel!,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.textHint,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}

class _HeatLegend extends StatelessWidget {
  const _HeatLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : AppSpacing.xs),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _heatmapColor(index),
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipItem {
  const _ChipItem({
    required this.id,
    required this.label,
    required this.selected,
  });

  final String id;
  final String label;
  final bool selected;
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 5.0;
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = AppPalette.white.withValues(alpha: AppOpacity.xxl)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, math.pi * 2, false, backgroundPaint);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * progress.clamp(0, 1).toDouble(),
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _ProgressLineChartPainter extends CustomPainter {
  const _ProgressLineChartPainter({
    required this.items,
  });

  final List<ProgressChartPoint> items;

  @override
  void paint(Canvas canvas, Size size) {
    if (items.length < 2) {
      return;
    }

    const leftInset = 8.0;
    const rightInset = 8.0;
    const topInset = 8.0;
    const bottomInset = 18.0;

    final values = [
      ...items.map((item) => item.userValue),
      ...items.map((item) => item.averageValue),
    ];
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    final range = math.max(1.0, maxValue - minValue);

    final usableWidth = size.width - leftInset - rightInset;
    final usableHeight = size.height - topInset - bottomInset;

    final gridPaint = Paint()
      ..color = AppPalette.white.withValues(alpha: AppOpacity.xxs)
      ..strokeWidth = AppStroke.hairline;

    for (var index = 0; index < 4; index++) {
      final y = topInset + usableHeight * index / 3;
      canvas.drawLine(
        Offset(leftInset, y),
        Offset(size.width - rightInset, y),
        gridPaint,
      );
    }

    Offset pointFor(double value, int index) {
      final dx = leftInset + (usableWidth / (items.length - 1)) * index;
      final normalized = (value - minValue) / range;
      final dy = topInset + usableHeight - (usableHeight * normalized);
      return Offset(dx, dy);
    }

    final averagePoints = <Offset>[];
    final userPoints = <Offset>[];

    for (var index = 0; index < items.length; index++) {
      final averagePoint = pointFor(items[index].averageValue, index);
      final userPoint = pointFor(items[index].userValue, index);
      averagePoints.add(averagePoint);
      userPoints.add(userPoint);
    }

    final averagePath = _buildSmoothPath(averagePoints);
    final userPath = _buildSmoothPath(userPoints);
    final fillPath = Path.from(userPath);
    final lastPoint = pointFor(items.last.userValue, items.length - 1);
    final firstPoint = pointFor(items.first.userValue, 0);
    fillPath
      ..lineTo(lastPoint.dx, size.height - bottomInset)
      ..lineTo(firstPoint.dx, size.height - bottomInset)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppPalette.primary.withValues(alpha: AppOpacity.emphasis),
          AppPalette.primary.withValues(alpha: AppOpacity.none),
        ],
      ).createShader(
        Rect.fromLTWH(0, topInset, size.width, usableHeight),
      );

    final averagePaint = Paint()
      ..color = AppPalette.textHint
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final userPaint = Paint()
      ..color = AppPalette.primary
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(fillPath, fillPaint);
    _drawDashedPath(canvas, averagePath, averagePaint);
    canvas.drawPath(userPath, userPaint);

    for (var index = 0; index < items.length; index++) {
      final userPoint = pointFor(items[index].userValue, index);
      canvas.drawCircle(
        userPoint,
        2.5,
        Paint()..color = AppPalette.primary,
      );
    }

    final highlightPaint = Paint()..color = AppPalette.primary;
    canvas.drawCircle(lastPoint, 4.5, highlightPaint);
    canvas.drawCircle(
      lastPoint,
      7.5,
      Paint()
        ..color = AppPalette.primary.withValues(alpha: AppOpacity.quarter)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressLineChartPainter oldDelegate) {
    return oldDelegate.items != items;
  }

  Path _buildSmoothPath(List<Offset> points) {
    final path = Path();
    if (points.isEmpty) {
      return path;
    }

    path.moveTo(points.first.dx, points.first.dy);
    if (points.length == 1) {
      return path;
    }

    for (var index = 0; index < points.length - 1; index++) {
      final current = points[index];
      final next = points[index + 1];
      final control = Offset((current.dx + next.dx) / 2, current.dy);
      final end = Offset((current.dx + next.dx) / 2, (current.dy + next.dy) / 2);
      path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
      path.quadraticBezierTo(next.dx, next.dy, next.dx, next.dy);
    }

    return path;
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      const dash = 7.0;
      const gap = 4.0;

      while (distance < metric.length) {
        final next = math.min(distance + dash, metric.length);
        final extract = metric.extractPath(distance, next);
        canvas.drawPath(extract, paint);
        distance += dash + gap;
      }
    }
  }
}

class _SkillRadarPainter extends CustomPainter {
  const _SkillRadarPainter({
    required this.items,
  });

  final List<ProgressSkillMetric> items;

  @override
  void paint(Canvas canvas, Size size) {
    if (items.isEmpty) {
      return;
    }

    final center = Offset(size.width / 2, size.height / 2 + 4);
    final radius = math.min(size.width, size.height) * 0.34;
    final axisCount = items.length;
    final stepPaint = Paint()
      ..color = AppPalette.white.withValues(alpha: AppOpacity.xxs)
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppStroke.hairline;
    final axisPaint = Paint()
      ..color = AppPalette.white.withValues(alpha: AppOpacity.xxs)
      ..strokeWidth = AppStroke.hairline;

    for (var step = 1; step <= 5; step++) {
      final polygon = Path();
      final currentRadius = radius * step / 5;
      for (var index = 0; index < axisCount; index++) {
        final angle = (-math.pi / 2) + (2 * math.pi * index / axisCount);
        final point = Offset(
          center.dx + currentRadius * math.cos(angle),
          center.dy + currentRadius * math.sin(angle),
        );
        if (index == 0) {
          polygon.moveTo(point.dx, point.dy);
        } else {
          polygon.lineTo(point.dx, point.dy);
        }
      }
      polygon.close();
      canvas.drawPath(polygon, stepPaint);
    }

    for (var index = 0; index < axisCount; index++) {
      final angle = (-math.pi / 2) + (2 * math.pi * index / axisCount);
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, point, axisPaint);

      final labelPoint = Offset(
        center.dx + (radius + 18) * math.cos(angle),
        center.dy + (radius + 18) * math.sin(angle),
      );
      _paintText(
        canvas,
        labelPoint,
        items[index].label,
      );
    }

    final dataPath = Path();
    for (var index = 0; index < axisCount; index++) {
      final angle = (-math.pi / 2) + (2 * math.pi * index / axisCount);
      final currentRadius = radius * (items[index].value / 100);
      final point = Offset(
        center.dx + currentRadius * math.cos(angle),
        center.dy + currentRadius * math.sin(angle),
      );
      if (index == 0) {
        dataPath.moveTo(point.dx, point.dy);
      } else {
        dataPath.lineTo(point.dx, point.dy);
      }
    }
    dataPath.close();

    final fillPaint = Paint()
      ..color = AppPalette.primary.withValues(alpha: AppOpacity.accent)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = AppPalette.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);

    for (var index = 0; index < axisCount; index++) {
      final angle = (-math.pi / 2) + (2 * math.pi * index / axisCount);
      final currentRadius = radius * (items[index].value / 100);
      final point = Offset(
        center.dx + currentRadius * math.cos(angle),
        center.dy + currentRadius * math.sin(angle),
      );
      canvas.drawCircle(point, 2.5, Paint()..color = AppPalette.primary);
    }
  }

  void _paintText(Canvas canvas, Offset center, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: AppPalette.textHint,
          fontSize: AppFontSize.caption,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 56);

    final offset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _SkillRadarPainter oldDelegate) {
    return oldDelegate.items != items;
  }
}

int? _extractLevelNumber(String label) {
  final match = RegExp(r'(\d+)').firstMatch(label);
  if (match == null) {
    return null;
  }

  return int.tryParse(match.group(1)!);
}

IconData _iconForMiniStat(String title) {
  final normalized = title.toLowerCase();

  if (normalized.contains('treino')) {
    return Icons.fitness_center_outlined;
  }
  if (normalized.contains('dura')) {
    return Icons.timer_outlined;
  }
  if (normalized.contains('calor')) {
    return Icons.local_fire_department_outlined;
  }
  if (normalized.contains('aula')) {
    return Icons.assignment_outlined;
  }

  return Icons.circle_outlined;
}

IconData _iconForLargeStat(String title) {
  final normalized = title.toLowerCase();

  if (normalized.contains('vitória') || normalized.contains('vitoria')) {
    return Icons.emoji_events_outlined;
  }
  if (normalized.contains('partida')) {
    return Icons.sports_tennis_outlined;
  }
  if (normalized.contains('bpm')) {
    return Icons.favorite_border_rounded;
  }
  if (normalized.contains('saque')) {
    return Icons.speed_outlined;
  }

  return Icons.insights_outlined;
}

Color _heatmapColor(int value) {
  switch (value) {
    case 4:
      return AppPalette.primary;
    case 3:
      return AppPalette.primary.withValues(alpha: 0.86);
    case 2:
      return AppPalette.primary.withValues(alpha: 0.62);
    case 1:
      return AppPalette.primary.withValues(alpha: 0.34);
    default:
      return AppPalette.white.withValues(alpha: AppOpacity.xxs);
  }
}

Color _hexToColor(String hex) {
  final normalized = hex.replaceFirst('#', '');
  final value = normalized.length == 6 ? 'FF$normalized' : normalized;
  return Color(int.parse(value, radix: 16));
}
