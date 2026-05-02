import 'package:flutter/material.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';

class HomeLeaderboardCard extends StatelessWidget {
  const HomeLeaderboardCard({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlowCard(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            children: overview.leaderboard
                .map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                      vertical: AppSpacing.xl,
                    ),
                    decoration: BoxDecoration(
                      color: entry.isCurrentUser
                          ? AppPalette.successHighlight
                          : AppPalette.glassBorder,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppIconSize.giant,
                          child: Text(
                            '${overview.uiLabels.leaderboardPositionPrefix}${entry.position}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: entry.position == 1
                                      ? AppPalette.gold
                                      : entry.position == 2
                                          ? AppPalette.silver
                                          : AppPalette.bronze,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        CircleAvatar(
                          radius: AppSize.leaderboardAvatarRadius,
                          backgroundImage: AssetImage(entry.avatarAsset),
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                entry.points,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppPalette.textSoft,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (entry.isCurrentUser)
                          Text(
                            overview.uiLabels.leaderboardCurrentUserLabel,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppPalette.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        else
                          Icon(
                            Icons.emoji_events_outlined,
                            color: entry.position == 1
                                ? AppPalette.gold
                                : Colors.transparent,
                            size: AppIconSize.lg,
                          ),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        GlowCard(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.huge,
            AppSpacing.huge,
            AppSpacing.huge,
            AppSpacing.xxxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overview.weeklyHeadline.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppPalette.textStats,
                      letterSpacing: AppLetterSpacing.wideSm,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Text(
                    overview.weeklyTrainings,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.successSoft,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Text(
                      overview.weeklyVariation,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                            color: AppPalette.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.huge),
              HomeBarChart(labels: overview.chartWeekdays),
              const SizedBox(height: AppSpacing.huge),
              Row(
                children: [
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.totalTime,
                      label: overview.uiLabels.weeklyTimeLabel,
                    ),
                  ),
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.calories,
                      label: overview.uiLabels.weeklyCaloriesLabel,
                    ),
                  ),
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.consistency,
                      label: overview.uiLabels.weeklyConsistencyLabel,
                      highlight: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeCalendarCard extends StatelessWidget {
  const HomeCalendarCard({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final cells = List<HomeCalendarCell?>.filled(4, null, growable: true)
      ..addAll(
        overview.calendarDays.map(
          (day) => HomeCalendarCell(
            label: day.label,
            isSelected: day.isSelected,
            imageAsset: day.imageAsset,
          ),
        ),
      );

    return GlowCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xxl,
        AppSpacing.xxl,
        AppSpacing.xxxl,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const HomeNavCircle(icon: Icons.chevron_left_rounded),
              const Spacer(),
              Text(
                overview.calendarMonthLabel[0].toUpperCase() +
                    overview.calendarMonthLabel.substring(1),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              const HomeNavCircle(icon: Icons.chevron_right_rounded),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            children: overview.calendarWeekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppPalette.textCalendar,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
            ),
            itemBuilder: (context, index) {
              final cell = cells[index];
              if (cell == null) {
                return const SizedBox.shrink();
              }

              if (cell.isSelected) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(AppRadius.xxxl),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cell.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPalette.black,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                );
              }

              if (cell.imageAsset != null) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(cell.imageAsset!),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: AppPalette.white.withValues(alpha: AppOpacity.lg),
                            width: AppStroke.hairline,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cell.label,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Container(
                      width: AppSize.ringSmall,
                      height: AppSize.ringSmall,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Text(
                  cell.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textDim,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomeBarChart extends StatelessWidget {
  const HomeBarChart({
    super.key,
    required this.labels,
  });

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSize.chartHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              AppChartHeights.weekly.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    height: AppChartHeights.weekly[index],
                    decoration: BoxDecoration(
                      color: AppPalette.chartBarA,
                      borderRadius: BorderRadius.circular(AppSize.chartBarWidthRadius),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: labels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppPalette.textAxis,
                          ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}

class HomeMiniBarChart extends StatelessWidget {
  const HomeMiniBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.miniChartHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          AppChartHeights.mini.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: AppChartHeights.mini[index],
                color: index.isEven ? AppPalette.chartBarB : AppPalette.chartBarC,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeStatMetric extends StatelessWidget {
  const HomeStatMetric({
    super.key,
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: highlight ? AppPalette.primary : AppPalette.white,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textStats,
              ),
        ),
      ],
    );
  }
}

class HomeNavCircle extends StatelessWidget {
  const HomeNavCircle({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.navCircle,
      height: AppSize.navCircle,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.calendarDark,
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xs),
        ),
      ),
      child: Icon(icon, size: AppIconSize.lg, color: AppPalette.iconSubtle),
    );
  }
}

class HomeCalendarCell {
  const HomeCalendarCell({
    required this.label,
    required this.isSelected,
    required this.imageAsset,
  });

  final String label;
  final bool isSelected;
  final String? imageAsset;
}

class HomeSportChip extends StatelessWidget {
  const HomeSportChip({
    super.key,
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: highlighted
            ? AppPalette.successDark
            : AppPalette.chipInactive,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted
              ? AppPalette.primary
              : AppPalette.textGlass,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
