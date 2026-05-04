import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
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
  const ProgressScoreCard({super.key, required this.overview});

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
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
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
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
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
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppPalette.textHint),
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
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppPalette.textHint),
                ),
                const Spacer(),
                Text(
                  nextLevel == null ? '' : 'Nv. $nextLevel',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppPalette.textHint),
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
              backgroundColor: AppPalette.white.withValues(
                alpha: AppOpacity.xxl,
              ),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppPalette.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${overview.levelProgressValue} / ${overview.levelProgressTarget}',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppPalette.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressStatsGrid extends StatelessWidget {
  const ProgressStatsGrid({super.key, required this.items});

  final List<ProgressStatCard> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (AppSpacing.md * 3)) / 4;
        final childAspectRatio = cardWidth / 64;

        return GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) =>
              _ProgressMiniStatCard(item: items[index]),
        );
      },
    );
  }
}

class ProgressPointsChartCard extends StatelessWidget {
  const ProgressPointsChartCard({super.key, required this.overview});

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.pointsSectionTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            overview.pointsSectionSubtitle,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPalette.textHint),
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
            child: LineChart(_buildProgressLineChartData(overview.pointsChart)),
          ),
        ],
      ),
    );
  }
}

class ProgressActivityRingsCard extends StatelessWidget {
  const ProgressActivityRingsCard({super.key, required this.overview});

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
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: AppPalette.textHint),
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
                        right: item == overview.activityRings.last
                            ? 0
                            : AppSpacing.sm,
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
  const ProgressSkillMapCard({super.key, required this.overview});

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.skillMapTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              Expanded(
                child: Text(
                  overview.skillMapSportLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppPalette.textHint),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.gps_fixed_rounded,
                    color: AppPalette.primary,
                    size: AppIconSize.md,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    overview.skillMapScoreLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 178,
            child: _RadarChartWithTooltip(items: overview.skillMetrics),
          ),
        ],
      ),
    );
  }
}

class ProgressConsistencyCard extends StatelessWidget {
  const ProgressConsistencyCard({super.key, required this.overview});

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    final heatmapRows = _transposeHeatmap(
      overview.consistencyHeatmap,
      overview.consistencyWeekdays.length,
    );
    const rowGap = AppSpacing.xs;
    const tileGapHorizontal = 2.0;
    const tileRadius = 3.0;

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
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPalette.textHint),
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              const axisWidth = 14.0;
              final columnCount = heatmapRows.isEmpty
                  ? 1
                  : heatmapRows.first.length;
              final gridWidth =
                  constraints.maxWidth - axisWidth - AppSpacing.sm;
              final slotWidth = gridWidth / columnCount;
              final tileSize = math.max(
                0.0,
                slotWidth - (tileGapHorizontal * 2),
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: axisWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        heatmapRows.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: index == heatmapRows.length - 1
                                ? 0
                                : rowGap,
                          ),
                          child: SizedBox(
                            height: tileSize,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                overview.consistencyWeekdays[index],
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: AppPalette.textHint,
                                      fontSize: AppFontSize.caption,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: heatmapRows
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: EdgeInsets.only(
                                bottom: entry.key == heatmapRows.length - 1
                                    ? 0
                                    : rowGap,
                              ),
                              child: Row(
                                children: entry.value
                                    .map(
                                      (value) => Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: tileGapHorizontal,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: _heatmapColor(value),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      tileRadius,
                                                    ),
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
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            height: AppStroke.hairline,
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: List.generate(overview.consistencySummary.length, (
              index,
            ) {
              final item = overview.consistencySummary[index];
              final isHighlighted = index == 1;

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.value,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: isHighlighted
                                ? AppPalette.primary
                                : AppPalette.white,
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
              );
            }),
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
            padding: EdgeInsets.zero,
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
  const ProgressLessonsCard({super.key, required this.overview});

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    final maxValue = overview.lessonsBars.fold<double>(
      0,
      (current, item) =>
          math.max(current, math.max(item.groupValue, item.privateValue)),
    );

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.lessonsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            overview.lessonsSubtitle,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPalette.textHint),
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
            child: BarChart(
              _buildLessonsBarChartData(
                overview.lessonsBars,
                maxValue == 0 ? 1 : maxValue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressRecordsCard extends StatelessWidget {
  const ProgressRecordsCard({super.key, required this.overview});

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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.giant,
                  ),
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
                      color: item.selected
                          ? AppPalette.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Center(
                      child: Text(
                        item.label,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: item.selected
                                  ? AppPalette.black
                                  : AppPalette.white,
                              fontWeight: item.selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
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
  const _HeaderActionButton({required this.icon, required this.onTap});

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
          size: icon == Icons.share_outlined
              ? AppIconSize.xxl
              : AppIconSize.huge,
        ),
      ),
    );
  }
}

class _ProgressMiniStatCard extends StatelessWidget {
  const _ProgressMiniStatCard({required this.item});

  final ProgressStatCard item;

  @override
  Widget build(BuildContext context) {
    final accentColor = AppPalette.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: item.highlighted
            ? AppPalette.successDark
            : AppPalette.surfaceAlt,
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
                color: item.highlighted
                    ? AppPalette.primary
                    : AppPalette.textHint,
              ),
              const Spacer(),
              Text(
                item.delta,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFontSize.body,
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
                      fontSize: 10,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressLargeStatCard extends StatelessWidget {
  const _ProgressLargeStatCard({required this.item});

  final ProgressStatCard item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.cardPaddingLg,
      decoration: BoxDecoration(
        color: item.highlighted
            ? AppPalette.successSoft
            : AppPalette.surfaceAlt,
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
                color: item.highlighted
                    ? AppPalette.primary
                    : AppPalette.textHint,
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
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppPalette.textMuted),
          ),
          if (item.subtitle != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.subtitle!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppPalette.textHint),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgressRingMetricWidget extends StatelessWidget {
  const _ProgressRingMetricWidget({required this.item});

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
              PieChart(
                PieChartData(
                  startDegreeOffset: -90,
                  sectionsSpace: 0,
                  centerSpaceRadius: 20,
                  centerSpaceColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  pieTouchData: PieTouchData(enabled: false),
                  sections: [
                    PieChartSectionData(
                      value: item.progress.clamp(0, 1).toDouble(),
                      color: ringColor,
                      radius: 10,
                      showTitle: false,
                      borderSide: BorderSide.none,
                    ),
                    PieChartSectionData(
                      value: 1 - item.progress.clamp(0, 1).toDouble(),
                      color: AppPalette.white.withValues(alpha: AppOpacity.xxl),
                      radius: 10,
                      showTitle: false,
                      borderSide: BorderSide.none,
                    ),
                  ],
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
  const _MatchRow({required this.item});

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

class _RecordsMetric extends StatelessWidget {
  const _RecordsMetric({required this.item});

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
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          item.delta,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppPalette.textMuted),
        ),
      ],
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});

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
  const _LegendDot({required this.color, required this.label});

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
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppPalette.textMuted),
        ),
      ],
    );
  }
}

class _RadarChartWithTooltip extends StatefulWidget {
  const _RadarChartWithTooltip({required this.items});

  final List<ProgressSkillMetric> items;

  @override
  State<_RadarChartWithTooltip> createState() => _RadarChartWithTooltipState();
}

class _RadarChartWithTooltipState extends State<_RadarChartWithTooltip> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            RadarChart(
              _buildRadarChartData(
                widget.items,
                touchedIndex: _touchedIndex,
                onTouch: (index) {
                  if (!mounted) return;
                  setState(() {
                    _touchedIndex = index;
                  });
                },
              ),
              swapAnimationDuration: Duration.zero,
              swapAnimationCurve: Curves.linear,
            ),
            if (_touchedIndex != null && _touchedIndex! < widget.items.length)
              _RadarTooltip(
                item: widget.items[_touchedIndex!],
                position: _radarTooltipOffset(
                  constraints.biggest,
                  _touchedIndex!,
                  widget.items.length,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _RadarTooltip extends StatelessWidget {
  const _RadarTooltip({required this.item, required this.position});

  final ProgressSkillMetric item;
  final Offset position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
              width: AppStroke.hairline,
            ),
            boxShadow: [
              BoxShadow(
                color: AppPalette.black.withValues(alpha: AppOpacity.emphasis),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                _formatRadarValue(item.value),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
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
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
      children: [
        Text(
          '-',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppPalette.textHint),
        ),
        const SizedBox(width: AppSpacing.xs),
        ...List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : AppSpacing.xs),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _heatmapColor(index),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '+',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppPalette.textHint),
        ),
      ],
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

LineChartData _buildProgressLineChartData(List<ProgressChartPoint> items) {
  final safeItems = items.isEmpty
      ? [ProgressChartPoint(label: '', userValue: 0, averageValue: 0)]
      : items;

  final values = [
    ...safeItems.map((item) => item.userValue),
    ...safeItems.map((item) => item.averageValue),
  ];
  final minValue = values.reduce(math.min);
  final maxValue = values.reduce(math.max);
  final padding = math.max(1.0, (maxValue - minValue) * 0.12);

  final averageSpots = List<FlSpot>.generate(
    safeItems.length,
    (index) => FlSpot(index.toDouble(), safeItems[index].averageValue),
  );
  final userSpots = List<FlSpot>.generate(
    safeItems.length,
    (index) => FlSpot(index.toDouble(), safeItems[index].userValue),
  );

  return LineChartData(
    minX: 0,
    maxX: (safeItems.length - 1).toDouble(),
    minY: minValue - padding,
    maxY: maxValue + padding,
    clipData: const FlClipData.all(),
    lineTouchData: LineTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchSpotThreshold: 24,
      getTouchedSpotIndicator: (barData, spotIndexes) {
        return spotIndexes.map((index) {
          final isPrimary = barData.color == AppPalette.primary;
          return TouchedSpotIndicatorData(
            FlLine(
              color: AppPalette.white.withValues(alpha: AppOpacity.quarter),
              strokeWidth: 1,
              dashArray: isPrimary ? null : const [4, 4],
            ),
            FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: isPrimary ? 5 : 4,
                color: isPrimary ? AppPalette.primary : AppPalette.surface,
                strokeWidth: 2,
                strokeColor: AppPalette.white,
              ),
            ),
          );
        }).toList();
      },
      touchTooltipData: LineTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        tooltipMargin: 12,
        tooltipPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        tooltipBorderRadius: BorderRadius.circular(AppRadius.xl),
        tooltipBorder: BorderSide(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
        getTooltipColor: (_) => AppPalette.surface,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            if (spot.barIndex != 1) {
              return null;
            }

            final item = safeItems[spot.x.toInt()];
            return LineTooltipItem(
              '${item.label}\n',
              const TextStyle(
                color: AppPalette.white,
                fontSize: AppFontSize.body,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'avg : ${_formatChartValue(item.averageValue)}\n',
                  style: const TextStyle(
                    color: AppPalette.textHint,
                    fontSize: AppFontSize.body,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'pts : ${_formatChartValue(item.userValue)}',
                  style: const TextStyle(
                    color: AppPalette.primary,
                    fontSize: AppFontSize.body,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            );
          }).toList();
        },
      ),
    ),
    borderData: FlBorderData(show: false),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: ((maxValue + padding) - (minValue - padding)) / 3,
      getDrawingHorizontalLine: (_) => FlLine(
        color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
        strokeWidth: AppStroke.hairline,
      ),
    ),
    titlesData: FlTitlesData(
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final index = value.round();
            if (index < 0 || index >= safeItems.length) {
              return const SizedBox.shrink();
            }
            return SideTitleWidget(
              meta: meta,
              child: Text(
                safeItems[index].label,
                style: const TextStyle(
                  color: AppPalette.textAxis,
                  fontSize: AppFontSize.caption,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: averageSpots,
        isCurved: true,
        color: AppPalette.textHint,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        dashArray: const [7, 4],
      ),
      LineChartBarData(
        spots: userSpots,
        isCurved: true,
        color: AppPalette.primary,
        barWidth: 2.4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) {
            final isLast = index == userSpots.length - 1;
            return FlDotCirclePainter(
              radius: isLast ? 3.6 : 2.2,
              color: AppPalette.primary,
              strokeWidth: isLast ? 2.8 : 0,
              strokeColor: isLast
                  ? AppPalette.primary.withValues(alpha: AppOpacity.quarter)
                  : Colors.transparent,
            );
          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppPalette.primary.withValues(alpha: AppOpacity.emphasis),
              AppPalette.primary.withValues(alpha: AppOpacity.none),
            ],
          ),
        ),
      ),
    ],
  );
}

RadarChartData _buildRadarChartData(
  List<ProgressSkillMetric> items, {
  required ValueChanged<int?> onTouch,
  int? touchedIndex,
}) {
  final safeItems = items.isEmpty
      ? [ProgressSkillMetric(label: '', value: 0)]
      : items;

  return RadarChartData(
    radarShape: RadarShape.polygon,
    radarBackgroundColor: Colors.transparent,
    radarBorderData: BorderSide.none,
    tickCount: 5,
    ticksTextStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
    tickBorderData: BorderSide(
      color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
      width: AppStroke.hairline,
    ),
    gridBorderData: BorderSide(
      color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
      width: AppStroke.hairline,
    ),
    titleTextStyle: const TextStyle(
      color: AppPalette.textHint,
      fontSize: AppFontSize.caption,
      fontWeight: FontWeight.w500,
    ),
    titlePositionPercentageOffset: 0.18,
    getTitle: (index, angle) {
      return RadarChartTitle(
        text: _shortRadarLabel(safeItems[index].label),
        angle: 0,
      );
    },
    dataSets: [
      RadarDataSet(
        dataEntries: safeItems
            .map((item) => RadarEntry(value: item.value))
            .toList(),
        borderColor: AppPalette.primary,
        fillColor: AppPalette.primary.withValues(alpha: AppOpacity.accent),
        borderWidth: 2,
        entryRadius: touchedIndex == null ? 2.5 : 3,
      ),
    ],
    radarTouchData: RadarTouchData(
      enabled: true,
      touchCallback: (event, response) {
        if (!event.isInterestedForInteractions) {
          return;
        }

        onTouch(response?.touchedSpot?.touchedRadarEntryIndex);
      },
    ),
  );
}

BarChartData _buildLessonsBarChartData(
  List<ProgressWeeklyLessonBar> items,
  double maxValue,
) {
  return BarChartData(
    minY: 0,
    maxY: maxValue * 1.12,
    alignment: BarChartAlignment.spaceBetween,
    groupsSpace: 8,
    barTouchData: BarTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchTooltipData: BarTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        tooltipMargin: 8,
        tooltipPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        tooltipBorderRadius: BorderRadius.circular(AppRadius.lg),
        tooltipBorder: BorderSide(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
        getTooltipColor: (_) => AppPalette.surface,
      ),
    ),
    borderData: FlBorderData(show: false),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: (maxValue * 1.12) / 3,
      getDrawingHorizontalLine: (_) => FlLine(
        color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
        strokeWidth: AppStroke.hairline,
      ),
    ),
    titlesData: FlTitlesData(
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          getTitlesWidget: (value, meta) {
            final index = value.round();
            if (index < 0 || index >= items.length) {
              return const SizedBox.shrink();
            }
            return SideTitleWidget(
              meta: meta,
              child: Text(
                items[index].label,
                style: const TextStyle(
                  color: AppPalette.textAxis,
                  fontSize: AppFontSize.caption,
                ),
              ),
            );
          },
        ),
      ),
    ),
    barGroups: List.generate(items.length, (index) {
      final item = items[index];
      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: item.groupValue,
            width: 10,
            color: AppPalette.primary,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxValue * 1.12,
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            ),
          ),
          BarChartRodData(
            toY: item.privateValue,
            width: 10,
            color: AppPalette.textHint,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxValue * 1.12,
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            ),
          ),
        ],
      );
    }),
  );
}

int? _extractLevelNumber(String label) {
  final match = RegExp(r'(\d+)').firstMatch(label);
  if (match == null) {
    return null;
  }

  return int.tryParse(match.group(1)!);
}

String _formatChartValue(double value) {
  final rounded = value.roundToDouble();
  if (value == rounded) {
    return value.round().toString();
  }

  return value.toStringAsFixed(1).replaceAll('.', ',');
}

String _formatRadarValue(double value) {
  final rounded = value.roundToDouble();
  if (value == rounded) {
    return value.round().toString();
  }

  return value.toStringAsFixed(1).replaceAll('.', ',');
}

String _shortRadarLabel(String label) {
  final normalized = label.trim().toLowerCase();

  switch (normalized) {
    case 'resistencia':
    case 'resistência':
      return 'Resist.';
    case 'backhand':
      return 'Backhand';
    case 'forehand':
      return 'Forehand';
    default:
      return label;
  }
}

List<List<int>> _transposeHeatmap(List<List<int>> weeks, int weekdayCount) {
  return List.generate(
    weekdayCount,
    (weekdayIndex) => List.generate(weeks.length, (weekIndex) {
      if (weekIndex >= weeks.length ||
          weekdayIndex >= weeks[weekIndex].length) {
        return 0;
      }

      return weeks[weekIndex][weekdayIndex];
    }),
  );
}

Offset _radarTooltipOffset(Size size, int index, int axisCount) {
  final center = Offset(size.width / 2, size.height / 2);
  final radius = math.min(size.width, size.height) * 0.28;
  final angle = (-math.pi / 2) + (2 * math.pi * index / axisCount);
  final point = Offset(
    center.dx + (radius + 18) * math.cos(angle),
    center.dy + (radius + 18) * math.sin(angle),
  );

  final dx = (point.dx - 44)
      .clamp(8.0, math.max(8.0, size.width - 96))
      .toDouble();
  final dy = (point.dy - 18)
      .clamp(8.0, math.max(8.0, size.height - 52))
      .toDouble();
  return Offset(dx, dy);
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
