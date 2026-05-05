import '../domain/training_comment.dart';
import '../domain/training_detail_overview.dart';
import '../domain/training_hero.dart';
import '../domain/training_metric.dart';

class TrainingDetailDto {
  TrainingDetailDto({required this.payload});

  factory TrainingDetailDto.fromJson(Map<String, dynamic> json) {
    return TrainingDetailDto(payload: json);
  }

  final Map<String, dynamic> payload;

  TrainingDetailOverview toDomain() {
    final hero = payload['hero'] as Map<String, dynamic>;
    return TrainingDetailOverview(
      id: payload['id'] as String,
      title: payload['title'] as String,
      subtitle: payload['subtitle'] as String,
      sportLabel: payload['sportLabel'] as String,
      dateLabel: payload['dateLabel'] as String,
      hero: TrainingHero(
        iconKey: hero['iconKey'] as String,
        primaryLabel: hero['primaryLabel'] as String,
        secondaryLabel: hero['secondaryLabel'] as String,
        tertiaryLabel: hero['tertiaryLabel'] as String,
      ),
      chips: (payload['chips'] as List<dynamic>).cast<String>(),
      summary: payload['summary'] as String,
      metricsTitle: payload['metricsTitle'] as String,
      metrics: parseMetrics(payload['metrics']),
      notesTitle: payload['notesTitle'] as String,
      notes: (payload['notes'] as List<dynamic>).cast<String>(),
      commentsTitle: payload['commentsTitle'] as String,
      comments: (payload['comments'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => TrainingComment(
              author: item['author'] as String,
              timeLabel: item['timeLabel'] as String,
              message: item['message'] as String,
              avatarAsset: item['avatarAsset'] as String?,
              initials: item['initials'] as String?,
            ),
          )
          .toList(growable: false),
      loadErrorMessage: payload['loadErrorMessage'] as String,
    );
  }
}

List<TrainingMetric> parseMetrics(Object? value) {
  if (value is! List) return const [];
  return value
      .cast<Map<String, dynamic>>()
      .map(
        (item) => TrainingMetric(
          label: item['label'] as String,
          value: item['value'] as String,
          delta: item['delta'] as String?,
          trend: item['trend'] as String?,
        ),
      )
      .toList(growable: false);
}
