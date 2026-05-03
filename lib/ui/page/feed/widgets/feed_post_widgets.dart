import 'package:flutter/material.dart';

import '../../../../domain/feed_post.dart';
import '../../../theme/app_theme.dart';
import 'feed_assets.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({
    super.key,
    required this.post,
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onShareTap,
    required this.onSaveTap,
  });

  final FeedPost post;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    final compact = isFeedCompactWidth(context);

    return Container(
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
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.huge,
              AppSpacing.huge,
              AppSpacing.huge,
              AppSpacing.xxxl,
            ),
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
          SizedBox(
            height: compact
                ? AppSize.feedPostImageHeightCompact
                : AppSize.feedPostImageHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  post.imageAsset,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: AppSpacing.giant,
                  left: AppSpacing.giant,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.warningDark.withValues(
                        alpha: AppOpacity.rich,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: AppSpacing.md,
                          height: AppSpacing.md,
                          decoration: const BoxDecoration(
                            color: AppPalette.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          post.sportLabel,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppPalette.white,
                                fontWeight: FontWeight.w600,
                                fontSize: AppFontSize.bodyLg,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              AppSpacing.xl,
              AppSpacing.page,
              AppSpacing.page,
            ),
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
                const SizedBox(height: AppSpacing.xl),
                TextButton(
                  onPressed: onCommentTap,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppPalette.textNeutral,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    post.viewCommentsLabel,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textNeutral,
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSize.body,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedPostAvatar extends StatelessWidget {
  const _FeedPostAvatar({
    required this.avatarAsset,
    required this.initials,
  });

  final String? avatarAsset;
  final String? initials;

  @override
  Widget build(BuildContext context) {
    if (avatarAsset != null) {
      return CircleAvatar(
        radius: AppSize.feedPostHeaderAvatar / 2,
        backgroundImage: AssetImage(avatarAsset!),
      );
    }

    return CircleAvatar(
      radius: AppSize.feedPostHeaderAvatar / 2,
      backgroundColor: AppPalette.surfaceAlt,
      child: Text(
        initials ?? '',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppPalette.white,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _FeedActionButton extends StatelessWidget {
  const _FeedActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppPalette.white,
              size: AppSize.feedPostActionIcon,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.white,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedIconOnlyButton extends StatelessWidget {
  const _FeedIconOnlyButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Icon(
          icon,
          color: AppPalette.white,
          size: AppSize.feedPostActionIcon,
        ),
      ),
    );
  }
}
