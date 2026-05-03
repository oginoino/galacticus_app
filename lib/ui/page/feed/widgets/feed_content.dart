import 'package:flutter/material.dart';

import '../../../../domain/feed_overview.dart';
import '../../../theme/app_theme.dart';
import 'feed_post_widgets.dart';
import 'feed_top_widgets.dart';

class FeedContent extends StatelessWidget {
  const FeedContent({
    super.key,
    required this.overview,
    required this.onMessage,
  });

  final FeedOverview overview;
  final ValueChanged<String> onMessage;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screen,
        topInset + AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.bottomContent,
      ),
      children: [
        FeedTopBar(overview: overview),
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
              onLikeTap: () => onMessage(overview.messages.likeAction),
              onCommentTap: () => onMessage(overview.messages.commentAction),
              onShareTap: () => onMessage(overview.messages.shareAction),
              onSaveTap: () => onMessage(overview.messages.saveAction),
            ),
            const SizedBox(height: AppSpacing.huge),
          ],
        ),
      ],
    );
  }
}
