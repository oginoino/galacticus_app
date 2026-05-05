import 'package:flutter/material.dart';

import '../../../../domain/feed_post.dart';
import '../../../../domain/feed_post_comment_preview.dart';
import '../../../../domain/feed_post_metric.dart';
import '../../../../domain/feed_workout_result_card.dart';
import '../../../components/checkin_overlay_view.dart';
import '../../../theme/app_theme.dart';
import 'feed_assets.dart';

part 'feed_post_shared_widgets.dart';
part 'feed_post_workout_widgets.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({
    super.key,
    required this.post,
    required this.onPostTap,
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onShareTap,
    required this.onSaveTap,
  });

  final FeedPost post;
  final VoidCallback onPostTap;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    final compact = isFeedCompactWidth(context);

    return InkWell(
      onTap: onPostTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        decoration: BoxDecoration(
          color: AppPalette.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppInsets.feedPostHeader,
              child: Row(
                children: [
                  _FeedPostAvatar(
                    avatarAsset: post.avatarAsset,
                    initials: post.initials,
                  ),
                  const SizedBox(width: AppSpacing.xxl),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorHandle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: AppLetterSpacing.tightMd,
                                fontSize: compact
                                    ? AppFontSize.titleLg
                                    : AppFontSize.headingSm,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          post.clubLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppPalette.textMuted,
                                fontSize: compact
                                    ? AppFontSize.body
                                    : AppFontSize.bodyLg,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Text(
                    post.timeAgoLabel,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textNeutral,
                          fontSize: compact
                              ? AppFontSize.body
                              : AppFontSize.bodyLg,
                        ),
                  ),
                ],
              ),
            ),
            _FeedPostMedia(
              post: post,
              compact: compact,
            ),
            Padding(
              padding: AppInsets.feedPostBody,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _FeedActionButton(
                        icon: Icons.favorite_border_rounded,
                        label: post.likesCountLabel,
                        onTap: onLikeTap,
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      _FeedActionButton(
                        icon: Icons.mode_comment_outlined,
                        label: post.commentsCountLabel,
                        onTap: onCommentTap,
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      _FeedIconOnlyButton(
                        icon: Icons.send_outlined,
                        onTap: onShareTap,
                      ),
                      const Spacer(),
                      _FeedIconOnlyButton(
                        icon: Icons.bookmark_border_rounded,
                        onTap: onSaveTap,
                      ),
                    ],
                  ),
                  if (post.commentPreview != null) ...[
                    const SizedBox(height: AppSpacing.xl),
                    _FeedCommentPreview(
                      preview: post.commentPreview!,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: onCommentTap,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: AppPalette.textNeutral,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          post.viewCommentsLabel,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppPalette.textMuted,
                                fontWeight: FontWeight.w500,
                                fontSize: AppFontSize.body,
                              ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppPalette.textMuted,
                          size: AppIconSize.xl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedPostMedia extends StatelessWidget {
  const _FeedPostMedia({
    required this.post,
    required this.compact,
  });

  final FeedPost post;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (post.layoutType == 'workout_result' && post.workoutResultCard != null) {
      return _FeedWorkoutResultCardWidget(
        post: post,
        card: post.workoutResultCard!,
        compact: compact,
      );
    }

    return SizedBox(
      height: compact
          ? AppSize.feedPostImageHeightCompact
          : AppSize.feedPostImageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            post.imageAsset!,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
                  ],
                  stops: const [0.48, 1],
                ),
              ),
            ),
          ),
          Positioned(
            top: AppInsets.feedPostMediaOverlay.top,
            left: AppInsets.feedPostMediaOverlay.left,
            child: _FeedSportBadge(
              label: post.sportLabel,
            ),
          ),
          if (post.floatingAvatarAsset != null)
            Positioned(
              top: AppInsets.feedPostMediaOverlay.top,
              right: AppInsets.feedPostMediaOverlay.right,
              child: Container(
                width: AppSize.feedPostFloatingAvatar,
                height: AppSize.feedPostFloatingAvatar,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppPalette.white,
                    width: AppStroke.thin,
                  ),
                  image: DecorationImage(
                    image: AssetImage(post.floatingAvatarAsset!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (post.checkinOverlay != null)
            Positioned(
              left: AppInsets.feedPostMediaOverlay.left,
              right: AppInsets.feedPostMediaOverlay.right,
              bottom: AppInsets.feedPostMediaOverlay.bottom,
              child: CheckinOverlayView(
                overlay: post.checkinOverlay!,
                compact: compact,
              ),
            )
          else if (post.layoutType == 'highlight')
            Positioned(
              left: AppInsets.feedPostMediaOverlay.left,
              right: AppInsets.feedPostMediaOverlay.right,
              bottom: AppInsets.feedPostMediaOverlay.bottom,
              child: _FeedPostHighlightOverlay(
                post: post,
                compact: compact,
              ),
            ),
        ],
      ),
    );
  }
}

class _FeedPostHighlightOverlay extends StatelessWidget {
  const _FeedPostHighlightOverlay({
    required this.post,
    required this.compact,
  });

  final FeedPost post;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (post.headline != null)
          Text(
            post.headline!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w700,
                  fontSize: compact
                      ? AppFontSize.headingSm
                      : AppFontSize.heading,
                  height: 1,
                ),
          ),
        if (post.subheadline != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            post.subheadline!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: compact ? AppFontSize.body : AppFontSize.bodyLg,
                  height: 1.2,
                ),
          ),
        ],
        if (post.metrics.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.giant),
          Row(
            children: post.metrics
                .map(
                  (metric) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: metric == post.metrics.last ? 0 : AppSpacing.md,
                      ),
                      child: _FeedMetricCard(
                        metric: metric,
                        compact: compact,
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
        if (post.locationLabel != null || post.weatherLabel != null) ...[
          const SizedBox(height: AppSpacing.giant),
          Row(
            children: [
              if (post.locationLabel != null)
                Flexible(
                  child: Text(
                    post.locationLabel!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.white,
                          fontSize: AppFontSize.body,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              if (post.locationLabel != null && post.weatherLabel != null)
                Text(
                  ' · ',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppPalette.textMuted,
                        fontSize: AppFontSize.body,
                      ),
                ),
              if (post.weatherLabel != null)
                Text(
                  post.weatherLabel!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppPalette.textMuted,
                        fontSize: AppFontSize.body,
                      ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
