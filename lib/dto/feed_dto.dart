import '../domain/feed_filter.dart';
import '../domain/feed_messages.dart';
import '../domain/feed_overview.dart';
import '../domain/feed_post.dart';
import '../domain/feed_story.dart';
import '../domain/feed_ui_labels.dart';

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
          authorHandle: item['authorHandle'] as String,
          clubLabel: item['clubLabel'] as String,
          timeAgoLabel: item['timeAgoLabel'] as String,
          avatarAsset: item['avatarAsset'] as String?,
          initials: item['initials'] as String?,
          imageAsset: item['imageAsset'] as String,
          sportLabel: item['sportLabel'] as String,
          likesCountLabel: item['likesCountLabel'] as String,
          commentsCountLabel: item['commentsCountLabel'] as String,
          viewCommentsLabel: item['viewCommentsLabel'] as String,
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
}
