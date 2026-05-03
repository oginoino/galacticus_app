import 'feed_filter.dart';
import 'feed_messages.dart';
import 'feed_post.dart';
import 'feed_story.dart';
import 'feed_ui_labels.dart';

class FeedOverview {
  const FeedOverview({
    required this.headerLogoAsset,
    required this.currentUserAvatarAsset,
    required this.stories,
    required this.filters,
    required this.posts,
    required this.uiLabels,
    required this.messages,
  });

  final String headerLogoAsset;
  final String currentUserAvatarAsset;
  final List<FeedStory> stories;
  final List<FeedFilter> filters;
  final List<FeedPost> posts;
  final FeedUiLabels uiLabels;
  final FeedMessages messages;
}
