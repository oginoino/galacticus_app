import 'checkin_overlay.dart';
import 'feed_post_comment_preview.dart';
import 'feed_post_metric.dart';
import 'feed_workout_result_card.dart';

class FeedPost {
  const FeedPost({
    required this.layoutType,
    required this.authorHandle,
    required this.clubLabel,
    required this.timeAgoLabel,
    required this.avatarAsset,
    required this.initials,
    required this.imageAsset,
    required this.sportLabel,
    required this.likesCountLabel,
    required this.commentsCountLabel,
    required this.viewCommentsLabel,
    this.headline,
    this.subheadline,
    this.locationLabel,
    this.weatherLabel,
    this.floatingAvatarAsset,
    this.metrics = const [],
    this.commentPreview,
    this.workoutResultCard,
    this.checkinOverlay,
  });

  final String layoutType;
  final String authorHandle;
  final String clubLabel;
  final String timeAgoLabel;
  final String? avatarAsset;
  final String? initials;
  final String? imageAsset;
  final String sportLabel;
  final String likesCountLabel;
  final String commentsCountLabel;
  final String viewCommentsLabel;
  final String? headline;
  final String? subheadline;
  final String? locationLabel;
  final String? weatherLabel;
  final String? floatingAvatarAsset;
  final List<FeedPostMetric> metrics;
  final FeedPostCommentPreview? commentPreview;
  final FeedWorkoutResultCard? workoutResultCard;
  final CheckinOverlay? checkinOverlay;
}
