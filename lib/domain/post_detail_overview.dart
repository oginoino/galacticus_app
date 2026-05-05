import 'checkin_overlay.dart';
import 'post_author_header.dart';
import 'post_badge.dart';
import 'post_comment.dart';
import 'post_counters.dart';
import 'training_metric.dart';

class PostDetailOverview {
  const PostDetailOverview({
    required this.id,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.badge,
    required this.author,
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.metrics,
    required this.counters,
    required this.commentsTitle,
    required this.comments,
    required this.replyPlaceholder,
    required this.loadErrorMessage,
    this.mediaImageAsset,
    this.checkinOverlay,
  });

  final String id;
  final String headerTitle;
  final String headerSubtitle;
  final PostBadge badge;
  final PostAuthorHeader author;
  final String title;
  final String subtitle;
  final List<String> tags;
  final List<TrainingMetric> metrics;
  final PostCounters counters;
  final String commentsTitle;
  final List<PostComment> comments;
  final String replyPlaceholder;
  final String loadErrorMessage;
  final String? mediaImageAsset;
  final CheckinOverlay? checkinOverlay;
}
