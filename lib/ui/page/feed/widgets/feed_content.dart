import 'package:flutter/material.dart';

import '../../../../domain/feed_overview.dart';
import '../../../../domain/feed_post.dart';
import '../../../theme/app_theme.dart';
import 'feed_post_widgets.dart';
import 'feed_top_widgets.dart';

class FeedContent extends StatelessWidget {
  const FeedContent({
    super.key,
    required this.overview,
    required this.onNotificationTap,
    required this.onMessage,
    required this.onPostTap,
  });

  final FeedOverview overview;
  final VoidCallback onNotificationTap;
  final ValueChanged<String> onMessage;
  final ValueChanged<FeedPost> onPostTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Column(
      children: [
        Padding(
          padding: AppResponsiveInsets.screenTopBar(topInset),
          child: FeedTopBar(
            overview: overview,
            onNotificationTap: onNotificationTap,
          ),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: AppInsets.feedPage,
            children: [
              const SizedBox(height: AppSpacing.giant),
              FeedStoriesSection(stories: overview.stories),
              const SizedBox(height: AppSpacing.huge),
              FeedFiltersRow(
                filters: overview.filters,
                onFilterAction: () => onMessage(overview.messages.filterAction),
              ),
              const SizedBox(height: AppSpacing.giant),
              ...overview.posts.expand(
                (post) => [
                  FeedPostCard(
                    post: post,
                    onPostTap: () => onPostTap(post),
                    onLikeTap: () => onMessage(overview.messages.likeAction),
                    onCommentTap: () => onMessage(overview.messages.commentAction),
                    onShareTap: () => onMessage(overview.messages.shareAction),
                    onSaveTap: () => onMessage(overview.messages.saveAction),
                  ),
                  const SizedBox(height: AppSpacing.huge),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
