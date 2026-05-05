import 'training_comment.dart';
import 'training_hero.dart';
import 'training_metric.dart';

class TrainingDetailOverview {
  const TrainingDetailOverview({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.sportLabel,
    required this.dateLabel,
    required this.hero,
    required this.chips,
    required this.summary,
    required this.metricsTitle,
    required this.metrics,
    required this.notesTitle,
    required this.notes,
    required this.commentsTitle,
    required this.comments,
    required this.loadErrorMessage,
  });

  final String id;
  final String title;
  final String subtitle;
  final String sportLabel;
  final String dateLabel;
  final TrainingHero hero;
  final List<String> chips;
  final String summary;
  final String metricsTitle;
  final List<TrainingMetric> metrics;
  final String notesTitle;
  final List<String> notes;
  final String commentsTitle;
  final List<TrainingComment> comments;
  final String loadErrorMessage;
}
