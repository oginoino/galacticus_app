import '../domain/feed_post_comment_preview.dart';
import '../domain/feed_post_metric.dart';
import '../domain/feed_workout_result_card.dart';
import '../domain/feed_filter.dart';
import '../domain/feed_messages.dart';
import '../domain/feed_overview.dart';
import '../domain/feed_post.dart';
import '../domain/feed_story.dart';
import '../domain/feed_ui_labels.dart';
import 'checkin_dto.dart';

class FeedDto {
  FeedDto({
    required this.payload,
  });

  factory FeedDto.fromJson(Map<String, dynamic> json) {
    return FeedDto(payload: json);
  }

  final Map<String, dynamic> payload;

  FeedOverview toDomain() {
    final assets = payload['assets'] as Map<String, dynamic>;
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return FeedOverview(
      headerLogoAsset: assets['headerLogoAsset'] as String,
      currentUserAvatarAsset: assets['currentUserAvatarAsset'] as String,
      stories: _mapList(
        payload['stories'] as List<dynamic>,
        (item) => FeedStory(
          label: item['label'] as String,
          avatarAsset: item['avatarAsset'] as String?,
          initials: item['initials'] as String?,
          ringColorHex: item['ringColorHex'] as String,
          hasAddBadge: item['hasAddBadge'] as bool,
        ),
      ),
      filters: _mapList(
        payload['filters'] as List<dynamic>,
        (item) => FeedFilter(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
        ),
      ),
      posts: _mapList(
        payload['posts'] as List<dynamic>,
        (item) => FeedPost(
          layoutType: item['layoutType'] as String,
          authorHandle: item['authorHandle'] as String,
          clubLabel: item['clubLabel'] as String,
          timeAgoLabel: item['timeAgoLabel'] as String,
          avatarAsset: item['avatarAsset'] as String?,
          initials: item['initials'] as String?,
          imageAsset: item['imageAsset'] as String?,
          sportLabel: item['sportLabel'] as String,
          likesCountLabel: item['likesCountLabel'] as String,
          commentsCountLabel: item['commentsCountLabel'] as String,
          viewCommentsLabel: item['viewCommentsLabel'] as String,
          headline: item['headline'] as String?,
          subheadline: item['subheadline'] as String?,
          locationLabel: item['locationLabel'] as String?,
          weatherLabel: item['weatherLabel'] as String?,
          floatingAvatarAsset: item['floatingAvatarAsset'] as String?,
          metrics: _mapMetrics(item['metrics'] as List<dynamic>?),
          commentPreview: _mapCommentPreview(
            item['commentPreview'] as Map<String, dynamic>?,
          ),
          workoutResultCard: _mapWorkoutResultCard(
            item['workoutResultCard'] as Map<String, dynamic>?,
          ),
          checkinOverlay: parseCheckinOverlay(item['checkinOverlay']),
        ),
      ),
      uiLabels: FeedUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      messages: FeedMessages(
        quickAction: messages['quickAction'] as String,
        filterAction: messages['filterAction'] as String,
        likeAction: messages['likeAction'] as String,
        commentAction: messages['commentAction'] as String,
        shareAction: messages['shareAction'] as String,
        saveAction: messages['saveAction'] as String,
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

  List<FeedPostMetric> _mapMetrics(List<dynamic>? source) {
    if (source == null) {
      return const [];
    }

    return source
        .cast<Map<String, dynamic>>()
        .map(
          (item) => FeedPostMetric(
            value: item['value'] as String,
            label: item['label'] as String,
          ),
        )
        .toList(growable: false);
  }

  FeedPostCommentPreview? _mapCommentPreview(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return FeedPostCommentPreview(
      initials: json['initials'] as String,
      authorLabel: json['authorLabel'] as String,
      message: json['message'] as String,
    );
  }

  FeedWorkoutResultCard? _mapWorkoutResultCard(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return FeedWorkoutResultCard(
      variant: json['variant'] as String,
      eyebrowLabel: json['eyebrowLabel'] as String,
      title: json['title'] as String,
      accentTitle: json['accentTitle'] as String?,
      subtitle: json['subtitle'] as String?,
      dateLabel: json['dateLabel'] as String?,
      startLabel: json['startLabel'] as String?,
      finishLabel: json['finishLabel'] as String?,
      badgeTitle: json['badgeTitle'] as String?,
      badgeSubtitle: json['badgeSubtitle'] as String?,
      locationLabel: json['locationLabel'] as String?,
      contextLabel: json['contextLabel'] as String?,
      footerDateLabel: json['footerDateLabel'] as String?,
      footerTagLabel: json['footerTagLabel'] as String?,
      trendLabel: json['trendLabel'] as String?,
      primaryMetrics: _mapMetrics(json['primaryMetrics'] as List<dynamic>?),
      secondaryMetrics: _mapMetrics(json['secondaryMetrics'] as List<dynamic>?),
    );
  }
}
