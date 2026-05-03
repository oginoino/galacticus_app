import 'package:flutter/material.dart';

import '../../../../domain/feed_post.dart';
import '../../../../domain/feed_post_comment_preview.dart';
import '../../../../domain/feed_post_metric.dart';
import '../../../../domain/feed_workout_result_card.dart';
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
            top: AppSpacing.giant,
            left: AppSpacing.giant,
            child: _FeedSportBadge(
              label: post.sportLabel,
            ),
          ),
          if (post.floatingAvatarAsset != null)
            Positioned(
              top: AppSpacing.giant,
              right: AppSpacing.giant,
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
          if (post.layoutType == 'highlight')
            Positioned(
              left: AppSpacing.giant,
              right: AppSpacing.giant,
              bottom: AppSpacing.giant,
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

class _FeedWorkoutResultCardWidget extends StatelessWidget {
  const _FeedWorkoutResultCardWidget({
    required this.post,
    required this.card,
    required this.compact,
  });

  final FeedPost post;
  final FeedWorkoutResultCard card;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final height = compact
        ? AppSize.feedWorkoutCardHeightCompact
        : AppSize.feedWorkoutCardHeight;

    return Container(
      height: height,
      margin: AppInsets.feedWorkoutCardMargin,
      decoration: BoxDecoration(
        color: AppPalette.black,
        borderRadius: BorderRadius.circular(AppRadius.cardXl),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppPalette.black,
                    AppPalette.black.withValues(alpha: AppOpacity.strong),
                  ],
                ),
              ),
            ),
          ),
          if (card.variant == 'technical') ...[
            const _TechnicalWorkoutBackdrop(),
          ] else if (card.variant == 'run') ...[
            const _RunWorkoutBackdrop(),
          ] else ...[
            const _FocusWorkoutBackdrop(),
          ],
          Padding(
            padding: AppInsets.feedWorkoutCardContent,
            child: _buildVariantContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantContent(BuildContext context) {
    switch (card.variant) {
      case 'technical':
        return _TechnicalWorkoutContent(
          post: post,
          card: card,
          compact: compact,
        );
      case 'run':
        return _RunWorkoutContent(
          card: card,
          compact: compact,
        );
      default:
        return _FocusWorkoutContent(
          card: card,
          compact: compact,
        );
    }
  }
}

class _TechnicalWorkoutBackdrop extends StatelessWidget {
  const _TechnicalWorkoutBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: AppSize.feedWorkoutBackdropInset,
          right: AppSize.feedWorkoutBackdropInset,
          top: AppSize.feedWorkoutBackdropTop,
          bottom: AppSize.feedWorkoutBackdropBottom,
          child: Transform.rotate(
            angle: 0.16,
            child: Container(
              decoration: BoxDecoration(
                color: AppPalette.black,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
            ),
          ),
        ),
        Positioned(
          left: AppSize.feedWorkoutNeonInset,
          right: AppSize.feedWorkoutNeonInset,
          bottom: AppSize.feedWorkoutNeonBottom,
          child: Container(
            height: AppStroke.thick,
            decoration: BoxDecoration(
              color: AppPalette.primary.withValues(alpha: AppOpacity.stronger),
              boxShadow: [
                BoxShadow(
                  color: AppPalette.primary.withValues(alpha: AppOpacity.overlayStrong),
                  blurRadius: AppSpacing.huge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RunWorkoutBackdrop extends StatelessWidget {
  const _RunWorkoutBackdrop();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _RunGridPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _FocusWorkoutBackdrop extends StatelessWidget {
  const _FocusWorkoutBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: AppSize.feedWorkoutOrbitTop,
          right: AppSize.feedWorkoutOrbitRight,
          child: Container(
            width: AppSize.feedWorkoutOrbitLarge,
            height: AppSize.feedWorkoutOrbitLarge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                width: AppStroke.hairline,
              ),
            ),
          ),
        ),
        Positioned(
          top: AppSize.feedWorkoutOrbitInnerTop,
          right: AppSize.feedWorkoutOrbitInnerRight,
          child: Container(
            width: AppSize.feedWorkoutOrbitInnerSize,
            height: AppSize.feedWorkoutOrbitInnerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                width: AppStroke.hairline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TechnicalWorkoutContent extends StatelessWidget {
  const _TechnicalWorkoutContent({
    required this.post,
    required this.card,
    required this.compact,
  });

  final FeedPost post;
  final FeedWorkoutResultCard card;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _FeedSportBadge(label: card.eyebrowLabel),
            const Spacer(),
            _WorkoutRingAvatar(initials: post.initials ?? ''),
          ],
        ),
        const Spacer(),
        Text(
          card.title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w700,
                fontSize: compact
                    ? AppFontSize.metricLg
                    : AppFontSize.displayLg,
                height: 0.95,
              ),
        ),
        if (card.subtitle != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            card.subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textNeutral,
                  fontSize: compact ? AppFontSize.titleLg : AppFontSize.headingSm,
                ),
          ),
        ],
        const SizedBox(height: AppSpacing.giant),
        Row(
          children: card.primaryMetrics
              .map(
                (metric) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: metric == card.primaryMetrics.last ? 0 : AppSpacing.md,
                    ),
                    child: _WorkoutGlassMetricCard(
                      metric: metric,
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: AppSpacing.giant),
        _WorkoutFooterLine(
          locationLabel: card.locationLabel,
          contextLabel: card.contextLabel,
        ),
      ],
    );
  }
}

class _RunWorkoutContent extends StatelessWidget {
  const _RunWorkoutContent({
    required this.card,
    required this.compact,
  });

  final FeedWorkoutResultCard card;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          card.eyebrowLabel,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textNeutral,
                letterSpacing: AppLetterSpacing.wideMd,
                fontSize: AppFontSize.bodyLg,
              ),
        ),
        const SizedBox(height: AppSpacing.giant),
        Text(
          card.title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w700,
                fontSize: compact
                    ? AppFontSize.displaySm
                    : AppFontSize.displayMd,
                height: 0.95,
              ),
        ),
        if (card.dateLabel != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            card.dateLabel!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textDim,
                  fontSize: AppFontSize.title,
                ),
          ),
        ],
        const SizedBox(height: AppSpacing.xxxl),
        if (card.startLabel != null)
          _WorkoutPill(
            label: card.startLabel!,
            highlighted: true,
          ),
        const SizedBox(height: AppSpacing.xxxl),
        if (card.finishLabel != null)
          _WorkoutPill(
            label: card.finishLabel!,
            highlighted: false,
          ),
        const SizedBox(height: AppSpacing.page),
        Expanded(
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.55,
            crossAxisSpacing: AppSpacing.giant,
            mainAxisSpacing: AppSpacing.giant,
            children: card.primaryMetrics
                .map(
                  (metric) => _WorkoutMetricBox(metric: metric),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: AppSpacing.giant),
        _WorkoutFooterLine(
          locationLabel: card.locationLabel,
          contextLabel: card.contextLabel,
        ),
      ],
    );
  }
}

class _FocusWorkoutContent extends StatelessWidget {
  const _FocusWorkoutContent({
    required this.card,
    required this.compact,
  });

  final FeedWorkoutResultCard card;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: constraints.maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        card.eyebrowLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppPalette.textNeutral,
                              letterSpacing: AppLetterSpacing.wideMd,
                              fontSize: AppFontSize.body,
                            ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    if (card.badgeTitle != null)
                      _WorkoutBadge(
                        title: card.badgeTitle!,
                        subtitle: card.badgeSubtitle ?? '',
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.page),
                Text(
                  card.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w700,
                        fontSize: compact
                            ? AppFontSize.displaySm
                            : AppFontSize.displayMd,
                        height: 0.98,
                      ),
                ),
                if (card.accentTitle != null)
                  Text(
                    card.accentTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppPalette.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: compact
                              ? AppFontSize.displaySm
                              : AppFontSize.displayMd,
                          height: 0.98,
                        ),
                  ),
                if (card.subtitle != null) ...[
                  const SizedBox(height: AppSpacing.giant),
                  Text(
                    card.subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textNeutral,
                          fontSize:
                              compact ? AppFontSize.titleSm : AppFontSize.title,
                          height: 1.22,
                        ),
                  ),
                ],
                const SizedBox(height: AppSpacing.giant),
                Row(
                  children: card.primaryMetrics
                      .map(
                        (metric) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: metric == card.primaryMetrics.last
                                  ? 0
                                  : AppSpacing.giant,
                            ),
                            child: _WorkoutPrimaryStat(metric: metric),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Container(
                  height: AppStroke.hairline,
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: card.secondaryMetrics
                      .map(
                        (metric) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: metric == card.secondaryMetrics.last
                                  ? 0
                                  : AppSpacing.giant,
                            ),
                            child: _WorkoutSecondaryStat(metric: metric),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Container(
                  height: AppStroke.hairline,
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                ),
                if (card.trendLabel != null) ...[
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    card.trendLabel!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textNeutral,
                          letterSpacing: AppLetterSpacing.tightMd,
                          fontSize: AppFontSize.body,
                        ),
                  ),
                ],
                const SizedBox(height: AppSpacing.page),
                _WorkoutFooterLine(
                  locationLabel: card.locationLabel,
                  contextLabel: card.contextLabel,
                  footerDateLabel: card.footerDateLabel,
                  footerTagLabel: card.footerTagLabel,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorkoutRingAvatar extends StatelessWidget {
  const _WorkoutRingAvatar({
    required this.initials,
  });

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.feedWorkoutAvatarRing,
      height: AppSize.feedWorkoutAvatarRing,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppPalette.primary.withValues(alpha: AppOpacity.strong),
          width: AppStroke.thin,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.xxs),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFA8A8A8),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _WorkoutGlassMetricCard extends StatelessWidget {
  const _WorkoutGlassMetricCard({
    required this.metric,
  });

  final FeedPostMetric metric;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompactMetric =
            constraints.maxWidth < 72 || constraints.maxHeight < 64;

        return Container(
          height: AppSize.feedWorkoutMetricCardHeight,
          decoration: BoxDecoration(
            color: AppPalette.glassDark,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
              width: AppStroke.hairline,
            ),
          ),
          padding: isCompactMetric
              ? AppInsets.feedWorkoutMetricCompact
              : AppInsets.feedWorkoutMetric,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  metric.value,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: metric.label.toLowerCase() == 'calorias'
                            ? AppPalette.primary
                            : AppPalette.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isCompactMetric
                            ? AppFontSize.titleLg
                            : AppFontSize.headingSm,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  metric.label.toUpperCase(),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppPalette.textDim,
                        fontSize: isCompactMetric
                            ? AppFontSize.labelLg
                            : AppFontSize.bodySm,
                        letterSpacing: AppLetterSpacing.tightMd,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WorkoutPill extends StatelessWidget {
  const _WorkoutPill({
    required this.label,
    required this.highlighted,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.feedPostBadge,
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.badgeLocation : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: highlighted ? AppPalette.primary : AppPalette.textNeutral,
              fontWeight: FontWeight.w700,
              letterSpacing: AppLetterSpacing.tightMd,
            ),
      ),
    );
  }
}

class _WorkoutMetricBox extends StatelessWidget {
  const _WorkoutMetricBox({
    required this.metric,
  });

  final FeedPostMetric metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.xxs),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      padding: AppInsets.feedWorkoutMetricBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            metric.label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textDim,
                  fontSize: AppFontSize.body,
                  letterSpacing: AppLetterSpacing.tightMd,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            metric.value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutBadge extends StatelessWidget {
  const _WorkoutBadge({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.feedWorkoutBadge,
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textNeutral,
                  fontSize: AppFontSize.bodySm,
                ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutPrimaryStat extends StatelessWidget {
  const _WorkoutPrimaryStat({
    required this.metric,
  });

  final FeedPostMetric metric;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metric.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textDim,
                fontSize: AppFontSize.body,
                letterSpacing: AppLetterSpacing.tightMd,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          metric.value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.display,
                height: 0.95,
              ),
        ),
      ],
    );
  }
}

class _WorkoutSecondaryStat extends StatelessWidget {
  const _WorkoutSecondaryStat({
    required this.metric,
  });

  final FeedPostMetric metric;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metric.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textDim,
                fontSize: AppFontSize.body,
                letterSpacing: AppLetterSpacing.tightMd,
              ),
        ),
        const SizedBox(height: AppSpacing.giant),
        Text(
          metric.value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppPalette.white,
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.heading,
              ),
        ),
      ],
    );
  }
}

class _WorkoutFooterLine extends StatelessWidget {
  const _WorkoutFooterLine({
    this.locationLabel,
    this.contextLabel,
    this.footerDateLabel,
    this.footerTagLabel,
  });

  final String? locationLabel;
  final String? contextLabel;
  final String? footerDateLabel;
  final String? footerTagLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (locationLabel != null)
          Expanded(
            child: Text(
              locationLabel!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textDim,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ),
        if (contextLabel != null)
          Expanded(
            child: Text(
              contextLabel!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textDim,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ),
        if (footerDateLabel != null)
          Expanded(
            child: Text(
              footerDateLabel!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textDim,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ),
        if (footerTagLabel != null)
          Expanded(
            child: Text(
              footerTagLabel!,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.body,
                    letterSpacing: AppLetterSpacing.tightMd,
                  ),
            ),
          ),
      ],
    );
  }
}

class _RunGridPainter extends CustomPainter {
  const _RunGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPalette.white.withValues(alpha: AppOpacity.xxs)
      ..strokeWidth = 1;

    const spacing = AppSize.feedWorkoutGridSpacing;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), AppSize.feedWorkoutGridDot, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
