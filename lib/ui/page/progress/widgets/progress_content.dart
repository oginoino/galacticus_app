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
    required this.onFilterTap,
    required this.onTimeRangeTap,
    required this.onStatsTap,
    required this.onMatchHistoryTap,
  });

  final ProgressOverview overview;
  final String? selectedFilterId;
  final String? selectedTimeRangeId;
  final ValueChanged<String> onFilterTap;
  final ValueChanged<String> onTimeRangeTap;
  final VoidCallback onStatsTap;
  final VoidCallback onMatchHistoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProgressFilterTabs(
          filters: overview.filters,
          timeRanges: overview.timeRanges,
          selectedFilterId: selectedFilterId ?? overview.selectedFilterId,
          selectedTimeRangeId:
              selectedTimeRangeId ?? overview.selectedTimeRangeId,
          onFilterTap: onFilterTap,
          onTimeRangeTap: onTimeRangeTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: Column(
            children: [
              ProgressScoreCard(overview: overview),
              const SizedBox(height: AppSpacing.lg),
              ProgressStatsGrid(items: overview.mainStats),
              const SizedBox(height: AppSpacing.lg),
              ProgressPointsChartCard(overview: overview),
              const SizedBox(height: AppSpacing.lg),
              ProgressActivityRingsCard(overview: overview),
              const SizedBox(height: AppSpacing.lg),
              ProgressSkillMapCard(overview: overview),
              const SizedBox(height: AppSpacing.lg),
              ProgressConsistencyCard(overview: overview),
              const SizedBox(height: AppSpacing.lg),
              ProgressTennisStatsCard(
                overview: overview,
                onTap: onStatsTap,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProgressMatchesCard(
                overview: overview,
                onTap: onMatchHistoryTap,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProgressLessonsCard(overview: overview),
              const SizedBox(height: AppSpacing.lg),
              ProgressRecordsCard(overview: overview),
            ],
          ),
        ),
      ],
    );
  }
}
