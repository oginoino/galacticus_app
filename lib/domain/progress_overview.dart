import 'progress_activity_ring_metric.dart';
import 'progress_chart_point.dart';
import 'progress_filter_option.dart';
import 'progress_match_result.dart';
import 'progress_messages.dart';
import 'progress_skill_metric.dart';
import 'progress_stat_card.dart';
import 'progress_time_range_option.dart';
import 'progress_ui_labels.dart';
import 'progress_weekly_lesson_bar.dart';

class ProgressOverview {
  const ProgressOverview({
    required this.title,
    required this.filters,
    required this.timeRanges,
    required this.selectedFilterId,
    required this.selectedTimeRangeId,
    required this.scoreTitle,
    required this.scoreValue,
    required this.scoreDelta,
    required this.levelLabel,
    required this.nextLevelLabel,
    required this.nextLevelRemainingLabel,
    required this.levelProgressValue,
    required this.levelProgressTarget,
    required this.mainStats,
    required this.pointsSectionTitle,
    required this.pointsSectionSubtitle,
    required this.pointsChart,
    required this.activitySectionTitle,
    required this.activityRings,
    required this.skillMapTitle,
    required this.skillMapSportLabel,
    required this.skillMapScoreLabel,
    required this.skillMetrics,
    required this.consistencyTitle,
    required this.consistencySubtitle,
    required this.consistencyWeekdays,
    required this.consistencyHeatmap,
    required this.consistencySummary,
    required this.tennisStatsTitle,
    required this.tennisStats,
    required this.matchesTitle,
    required this.matches,
    required this.lessonsTitle,
    required this.lessonsSubtitle,
    required this.lessonsBars,
    required this.recordsTitle,
    required this.records,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final List<ProgressFilterOption> filters;
  final List<ProgressTimeRangeOption> timeRanges;
  final String selectedFilterId;
  final String selectedTimeRangeId;
  final String scoreTitle;
  final String scoreValue;
  final String scoreDelta;
  final String levelLabel;
  final String nextLevelLabel;
  final String nextLevelRemainingLabel;
  final int levelProgressValue;
  final int levelProgressTarget;
  final List<ProgressStatCard> mainStats;
  final String pointsSectionTitle;
  final String pointsSectionSubtitle;
  final List<ProgressChartPoint> pointsChart;
  final String activitySectionTitle;
  final List<ProgressActivityRingMetric> activityRings;
  final String skillMapTitle;
  final String skillMapSportLabel;
  final String skillMapScoreLabel;
  final List<ProgressSkillMetric> skillMetrics;
  final String consistencyTitle;
  final String consistencySubtitle;
  final List<String> consistencyWeekdays;
  final List<List<int>> consistencyHeatmap;
  final List<ProgressStatCard> consistencySummary;
  final String tennisStatsTitle;
  final List<ProgressStatCard> tennisStats;
  final String matchesTitle;
  final List<ProgressMatchResult> matches;
  final String lessonsTitle;
  final String lessonsSubtitle;
  final List<ProgressWeeklyLessonBar> lessonsBars;
  final String recordsTitle;
  final List<ProgressStatCard> records;
  final ProgressUiLabels uiLabels;
  final ProgressMessages messages;
}
