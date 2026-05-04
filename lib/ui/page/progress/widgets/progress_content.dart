import 'package:flutter/material.dart';

import '../../../../domain/progress_overview.dart';
import '../../../theme/app_theme.dart';
import 'progress_widgets.dart';

class ProgressContent extends StatelessWidget {
  const ProgressContent({
    super.key,
    required this.overview,
    required this.selectedFilterId,
    required this.selectedTimeRangeId,
    required this.onBackTap,
    required this.onShareTap,
    required this.onFilterTap,
    required this.onTimeRangeTap,
    required this.onStatsTap,
    required this.onMatchHistoryTap,
  });

  final ProgressOverview overview;
  final String? selectedFilterId;
  final String? selectedTimeRangeId;
  final VoidCallback onBackTap;
  final VoidCallback onShareTap;
  final ValueChanged<String> onFilterTap;
  final ValueChanged<String> onTimeRangeTap;
  final VoidCallback onStatsTap;
  final VoidCallback onMatchHistoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProgressHeader(
          title: overview.title,
          filters: overview.filters,
          timeRanges: overview.timeRanges,
          selectedFilterId: selectedFilterId ?? overview.selectedFilterId,
          selectedTimeRangeId: selectedTimeRangeId ?? overview.selectedTimeRangeId,
          onBackTap: onBackTap,
          onShareTap: onShareTap,
          onFilterTap: onFilterTap,
          onTimeRangeTap: onTimeRangeTap,
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              0,
              AppSpacing.page,
              AppSpacing.bottomContent,
            ),
            children: [
              ProgressScoreCard(overview: overview),
              const SizedBox(height: AppSpacing.sm),
              ProgressStatsGrid(items: overview.mainStats),
              const SizedBox(height: AppSpacing.sm),
              ProgressPointsChartCard(overview: overview),
              const SizedBox(height: AppSpacing.md),
              ProgressActivityRingsCard(overview: overview),
              const SizedBox(height: AppSpacing.md),
              ProgressSkillMapCard(overview: overview),
              const SizedBox(height: AppSpacing.md),
              ProgressConsistencyCard(overview: overview),
              const SizedBox(height: AppSpacing.md),
              ProgressTennisStatsCard(
                overview: overview,
                onTap: onStatsTap,
              ),
              const SizedBox(height: AppSpacing.md),
              ProgressMatchesCard(
                overview: overview,
                onTap: onMatchHistoryTap,
              ),
              const SizedBox(height: AppSpacing.md),
              ProgressLessonsCard(overview: overview),
              const SizedBox(height: AppSpacing.md),
              ProgressRecordsCard(overview: overview),
            ],
          ),
        ),
      ],
    );
  }
}
