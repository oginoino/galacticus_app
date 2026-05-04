import '../domain/progress_activity_ring_metric.dart';
import '../domain/progress_chart_point.dart';
import '../domain/progress_filter_option.dart';
import '../domain/progress_match_result.dart';
import '../domain/progress_messages.dart';
import '../domain/progress_overview.dart';
import '../domain/progress_skill_metric.dart';
import '../domain/progress_stat_card.dart';
import '../domain/progress_time_range_option.dart';
import '../domain/progress_ui_labels.dart';
import '../domain/progress_weekly_lesson_bar.dart';

class ProgressDto {
  ProgressDto({
    required this.payload,
  });

  factory ProgressDto.fromJson(Map<String, dynamic> json) {
    return ProgressDto(payload: json);
  }

  final Map<String, dynamic> payload;

  ProgressOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;
    final levelProgress = payload['levelProgress'] as Map<String, dynamic>;
    final skillMap = payload['skillMap'] as Map<String, dynamic>;
    final consistency = payload['consistency'] as Map<String, dynamic>;

    return ProgressOverview(
      title: payload['title'] as String,
      filters: _mapList(
        payload['filters'] as List<dynamic>,
        (item) => ProgressFilterOption(
          id: item['id'] as String,
          label: item['label'] as String,
        ),
      ),
      timeRanges: _mapList(
        payload['timeRanges'] as List<dynamic>,
        (item) => ProgressTimeRangeOption(
          id: item['id'] as String,
          label: item['label'] as String,
        ),
      ),
      selectedFilterId: payload['selectedFilterId'] as String,
      selectedTimeRangeId: payload['selectedTimeRangeId'] as String,
      scoreTitle: payload['scoreTitle'] as String,
      scoreValue: payload['scoreValue'] as String,
      scoreDelta: payload['scoreDelta'] as String,
      levelLabel: payload['levelLabel'] as String,
      nextLevelLabel: payload['nextLevelLabel'] as String,
      nextLevelRemainingLabel: payload['nextLevelRemainingLabel'] as String,
      levelProgressValue: levelProgress['value'] as int,
      levelProgressTarget: levelProgress['target'] as int,
      mainStats: _mapList(
        payload['mainStats'] as List<dynamic>,
        (item) => ProgressStatCard(
          title: item['title'] as String,
          value: item['value'] as String,
          delta: item['delta'] as String,
          subtitle: item['subtitle'] as String?,
          highlighted: item['highlighted'] as bool? ?? false,
        ),
      ),
      pointsSectionTitle: payload['pointsSectionTitle'] as String,
      pointsSectionSubtitle: payload['pointsSectionSubtitle'] as String,
      pointsChart: _mapList(
        payload['pointsChart'] as List<dynamic>,
        (item) => ProgressChartPoint(
          label: item['label'] as String,
          userValue: (item['userValue'] as num).toDouble(),
          averageValue: (item['averageValue'] as num).toDouble(),
        ),
      ),
      activitySectionTitle: payload['activitySectionTitle'] as String,
      activityRings: _mapList(
        payload['activityRings'] as List<dynamic>,
        (item) => ProgressActivityRingMetric(
          title: item['title'] as String,
          value: item['value'] as String,
          targetLabel: item['targetLabel'] as String,
          progress: (item['progress'] as num).toDouble(),
          colorHex: item['colorHex'] as String,
        ),
      ),
      skillMapTitle: payload['skillMapTitle'] as String,
      skillMapSportLabel: skillMap['sportLabel'] as String,
      skillMapScoreLabel: skillMap['scoreLabel'] as String,
      skillMetrics: _mapList(
        skillMap['metrics'] as List<dynamic>,
        (item) => ProgressSkillMetric(
          label: item['label'] as String,
          value: (item['value'] as num).toDouble(),
        ),
      ),
      consistencyTitle: payload['consistencyTitle'] as String,
      consistencySubtitle: payload['consistencySubtitle'] as String,
      consistencyWeekdays: (consistency['weekdays'] as List<dynamic>)
          .cast<String>()
          .toList(growable: false),
      consistencyHeatmap: (consistency['heatmap'] as List<dynamic>)
          .map(
            (week) => (week as List<dynamic>)
                .map((value) => value as int)
                .toList(growable: false),
          )
          .toList(growable: false),
      consistencySummary: _mapList(
        consistency['summary'] as List<dynamic>,
        (item) => ProgressStatCard(
          title: item['title'] as String,
          value: item['value'] as String,
          delta: item['delta'] as String,
          subtitle: item['subtitle'] as String?,
          highlighted: item['highlighted'] as bool? ?? false,
        ),
      ),
      tennisStatsTitle: payload['tennisStatsTitle'] as String,
      tennisStats: _mapList(
        payload['tennisStats'] as List<dynamic>,
        (item) => ProgressStatCard(
          title: item['title'] as String,
          value: item['value'] as String,
          delta: item['delta'] as String,
          subtitle: item['subtitle'] as String?,
          highlighted: item['highlighted'] as bool? ?? false,
        ),
      ),
      matchesTitle: payload['matchesTitle'] as String,
      matches: _mapList(
        payload['matches'] as List<dynamic>,
        (item) => ProgressMatchResult(
          result: item['result'] as String,
          opponent: item['opponent'] as String,
          dateLabel: item['dateLabel'] as String,
          score: item['score'] as String,
        ),
      ),
      lessonsTitle: payload['lessonsTitle'] as String,
      lessonsSubtitle: payload['lessonsSubtitle'] as String,
      lessonsBars: _mapList(
        payload['lessonsBars'] as List<dynamic>,
        (item) => ProgressWeeklyLessonBar(
          label: item['label'] as String,
          groupValue: (item['groupValue'] as num).toDouble(),
          privateValue: (item['privateValue'] as num).toDouble(),
        ),
      ),
      recordsTitle: payload['recordsTitle'] as String,
      records: _mapList(
        payload['records'] as List<dynamic>,
        (item) => ProgressStatCard(
          title: item['title'] as String,
          value: item['value'] as String,
          delta: item['delta'] as String,
          subtitle: item['subtitle'] as String?,
          highlighted: item['highlighted'] as bool? ?? false,
        ),
      ),
      uiLabels: ProgressUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
        pointsChartYouLabel: uiLabels['pointsChartYouLabel'] as String,
        pointsChartAverageLabel: uiLabels['pointsChartAverageLabel'] as String,
        activityTodayLabel: uiLabels['activityTodayLabel'] as String,
        skillsAssessmentLabel: uiLabels['skillsAssessmentLabel'] as String,
        tennisStatsActionLabel: uiLabels['tennisStatsActionLabel'] as String,
        matchesActionLabel: uiLabels['matchesActionLabel'] as String,
        lessonsGroupLabel: uiLabels['lessonsGroupLabel'] as String,
        lessonsPrivateLabel: uiLabels['lessonsPrivateLabel'] as String,
      ),
      messages: ProgressMessages(
        quickAction: messages['quickAction'] as String,
        filterAction: messages['filterAction'] as String,
        rangeAction: messages['rangeAction'] as String,
        matchHistoryAction: messages['matchHistoryAction'] as String,
        statsAction: messages['statsAction'] as String,
      ),
    );
  }

  List<T> _mapList<T>(
    List<dynamic> source,
    T Function(Map<String, dynamic> json) mapper,
  ) {
    return source
        .cast<Map<String, dynamic>>()
        .map(mapper)
        .toList(growable: false);
  }
}
