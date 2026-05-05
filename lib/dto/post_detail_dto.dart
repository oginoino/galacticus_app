import '../domain/post_author_header.dart';
import '../domain/post_badge.dart';
import '../domain/post_comment.dart';
import '../domain/post_counters.dart';
import '../domain/post_detail_overview.dart';
import 'checkin_dto.dart';
import 'training_detail_dto.dart';

class PostDetailDto {
  PostDetailDto({required this.payload});

  factory PostDetailDto.fromJson(Map<String, dynamic> json) {
    return PostDetailDto(payload: json);
  }

  final Map<String, dynamic> payload;

  PostDetailOverview toDomain() {
    final badge = payload['badge'] as Map<String, dynamic>;
    final author = payload['author'] as Map<String, dynamic>;
    final counters = payload['counters'] as Map<String, dynamic>;

    return PostDetailOverview(
      id: payload['id'] as String,
      headerTitle: payload['headerTitle'] as String,
      headerSubtitle: payload['headerSubtitle'] as String,
      badge: PostBadge(
        label: badge['label'] as String,
        highlighted: badge['highlighted'] as bool? ?? false,
      ),
      author: PostAuthorHeader(
        authorHandle: author['authorHandle'] as String,
        contextLabel: author['contextLabel'] as String,
        avatarAsset: author['avatarAsset'] as String?,
        initials: author['initials'] as String?,
      ),
      title: payload['title'] as String,
      subtitle: payload['subtitle'] as String,
      mediaImageAsset: payload['mediaImageAsset'] as String?,
      checkinOverlay: parseCheckinOverlay(payload['checkinOverlay']),
      tags: (payload['tags'] as List<dynamic>).cast<String>(),
      metrics: parseMetrics(payload['metrics']),
      counters: PostCounters(
        likesLabel: counters['likesLabel'] as String,
        commentsLabel: counters['commentsLabel'] as String,
        sharesLabel: counters['sharesLabel'] as String,
        savedLabel: counters['savedLabel'] as String,
      ),
      commentsTitle: payload['commentsTitle'] as String,
      comments: (payload['comments'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => PostComment(
              author: item['author'] as String,
              timeLabel: item['timeLabel'] as String,
              message: item['message'] as String,
              likesLabel: item['likesLabel'] as String,
              avatarAsset: item['avatarAsset'] as String?,
              initials: item['initials'] as String?,
            ),
          )
          .toList(growable: false),
      replyPlaceholder: payload['replyPlaceholder'] as String,
      loadErrorMessage: payload['loadErrorMessage'] as String,
    );
  }
}
