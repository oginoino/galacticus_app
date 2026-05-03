part of 'feed_post_widgets.dart';

class _FeedSportBadge extends StatelessWidget {
  const _FeedSportBadge({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.feedPostBadge,
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
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w600,
                  fontSize: AppFontSize.bodyLg,
                ),
          ),
        ],
      ),
    );
  }
}

class _FeedMetricCard extends StatelessWidget {
  const _FeedMetricCard({
    required this.metric,
    required this.compact,
  });

  final FeedPostMetric metric;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact
          ? AppSize.feedPostMetricBadgeHeightCompact
          : AppSize.feedPostMetricBadgeHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.giant,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppPalette.glassDark,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.sm),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            metric.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w700,
                  fontSize: compact
                      ? AppFontSize.titleLg
                      : AppFontSize.headingSm,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            metric.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.bodySm,
                ),
          ),
        ],
      ),
    );
  }
}

class _FeedCommentPreview extends StatelessWidget {
  const _FeedCommentPreview({
    required this.preview,
  });

  final FeedPostCommentPreview preview;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSize.feedWorkoutCommentAvatar,
          height: AppSize.feedWorkoutCommentAvatar,
          decoration: const BoxDecoration(
            color: AppPalette.surfaceAlt,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            preview.initials,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.bodySm,
                ),
          ),
        ),
        const SizedBox(width: AppSpacing.giant),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textMuted,
                    fontSize: AppFontSize.body,
                    height: 1.25,
                  ),
              children: [
                TextSpan(
                  text: '${preview.authorLabel} ',
                  style: const TextStyle(
                    color: AppPalette.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: preview.message),
              ],
            ),
          ),
        ),
      ],
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
        padding: AppInsets.sectionAction,
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
        padding: AppInsets.sectionAction,
        child: Icon(
          icon,
          color: AppPalette.white,
          size: AppSize.feedPostActionIcon,
        ),
      ),
    );
  }
}
