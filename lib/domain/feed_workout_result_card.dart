import 'feed_post_metric.dart';

class FeedWorkoutResultCard {
  const FeedWorkoutResultCard({
    required this.variant,
    required this.eyebrowLabel,
    required this.title,
    this.accentTitle,
    this.subtitle,
    this.dateLabel,
    this.startLabel,
    this.finishLabel,
    this.badgeTitle,
    this.badgeSubtitle,
    this.locationLabel,
    this.contextLabel,
    this.footerDateLabel,
    this.footerTagLabel,
    this.trendLabel,
    this.primaryMetrics = const [],
    this.secondaryMetrics = const [],
  });

  final String variant;
  final String eyebrowLabel;
  final String title;
  final String? accentTitle;
  final String? subtitle;
  final String? dateLabel;
  final String? startLabel;
  final String? finishLabel;
  final String? badgeTitle;
  final String? badgeSubtitle;
  final String? locationLabel;
  final String? contextLabel;
  final String? footerDateLabel;
  final String? footerTagLabel;
  final String? trendLabel;
  final List<FeedPostMetric> primaryMetrics;
  final List<FeedPostMetric> secondaryMetrics;
}
