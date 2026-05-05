import 'package:flutter/material.dart';

import '../../../../domain/checkin_overlay.dart';
import '../../../../domain/post_author_header.dart';
import '../../../../domain/post_badge.dart';
import '../../../../domain/post_comment.dart';
import '../../../../domain/post_counters.dart';
import '../../../components/checkin_overlay_view.dart';
import '../../../theme/app_theme.dart';

class PostAuthorRow extends StatelessWidget {
  const PostAuthorRow({super.key, required this.author});

  final PostAuthorHeader author;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Avatar(
          avatarAsset: author.avatarAsset,
          initials: author.initials,
          size: 48,
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.authorHandle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.titleSm,
                    ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                author.contextLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppPalette.textHint,
                      fontSize: AppFontSize.bodySm,
                    ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.more_horiz_rounded,
          color: AppPalette.textHint,
          size: AppIconSize.xl,
        ),
      ],
    );
  }
}

class PostBadgeChip extends StatelessWidget {
  const PostBadgeChip({super.key, required this.badge});

  final PostBadge badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: badge.highlighted
            ? AppPalette.primary.withValues(alpha: AppOpacity.medium)
            : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: badge.highlighted
              ? AppPalette.primary
              : AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Text(
        badge.label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: badge.highlighted
                  ? AppPalette.primary
                  : AppPalette.textSecondary,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.bodySm,
              letterSpacing: AppLetterSpacing.wideSm,
            ),
      ),
    );
  }
}

class PostMediaCard extends StatelessWidget {
  const PostMediaCard({
    super.key,
    required this.imageAsset,
    this.checkinOverlay,
  });

  final String imageAsset;
  final CheckinOverlay? checkinOverlay;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imageAsset, fit: BoxFit.cover),
            if (checkinOverlay != null)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppPalette.black.withValues(alpha: AppOpacity.scrim),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),
            if (checkinOverlay != null)
              Positioned(
                left: AppSpacing.giant,
                right: AppSpacing.giant,
                bottom: AppSpacing.giant,
                child: CheckinOverlayView(
                  overlay: checkinOverlay!,
                  compact: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PostCountersRow extends StatelessWidget {
  const PostCountersRow({super.key, required this.counters});

  final PostCounters counters;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        _Counter(
          icon: Icons.favorite_border_rounded,
          label: counters.likesLabel,
        ),
        _Counter(
          icon: Icons.chat_bubble_outline_rounded,
          label: counters.commentsLabel,
        ),
        _Counter(
          icon: Icons.send_outlined,
          label: counters.sharesLabel,
        ),
      ],
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppPalette.textSecondary, size: AppIconSize.md),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.textSecondary,
                  fontSize: AppFontSize.bodySm,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class PostCommentsList extends StatelessWidget {
  const PostCommentsList({
    super.key,
    required this.title,
    required this.comments,
  });

  final String title;
  final List<PostComment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final comment in comments) ...[
          if (comment != comments.first)
            const SizedBox(height: AppSpacing.md),
          PostCommentCard(comment: comment),
        ],
      ],
    );
  }
}

class PostCommentCard extends StatelessWidget {
  const PostCommentCard({super.key, required this.comment});

  final PostComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(
            avatarAsset: comment.avatarAsset,
            initials: comment.initials,
            size: 36,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.author,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppFontSize.bodyLg,
                            ),
                      ),
                    ),
                    Text(
                      comment.timeLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppPalette.textHint,
                            fontSize: AppFontSize.bodySm,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  comment.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textSecondary,
                        fontSize: AppFontSize.bodyLg,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: AppPalette.textHint,
                      size: AppIconSize.sm,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      comment.likesLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppPalette.textHint,
                            fontSize: AppFontSize.label,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostReplyComposer extends StatelessWidget {
  const PostReplyComposer({super.key, required this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              placeholder,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppPalette.textHint,
                    fontSize: AppFontSize.bodyLg,
                  ),
            ),
          ),
          const Icon(
            Icons.send_rounded,
            color: AppPalette.primary,
            size: AppIconSize.lg,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.avatarAsset,
    required this.initials,
    required this.size,
  });

  final String? avatarAsset;
  final String? initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.surfaceAlt,
        image: avatarAsset != null
            ? DecorationImage(
                image: AssetImage(avatarAsset!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: avatarAsset == null
          ? Text(
              initials ?? '·',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPalette.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.bodyLg,
                  ),
            )
          : null,
    );
  }
}
