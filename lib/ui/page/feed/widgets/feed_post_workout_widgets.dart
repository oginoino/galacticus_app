part of 'feed_post_widgets.dart';

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
        final isUltraCompactMetric =
            constraints.maxWidth < 52 || constraints.maxHeight < 58;

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
          padding: isUltraCompactMetric
              ? EdgeInsets.zero
              : isCompactMetric
                  ? AppInsets.feedWorkoutMetricCompact
                  : AppInsets.feedWorkoutMetric,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Center(
                  child: FittedBox(
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
                ),
              ),
              if (!isUltraCompactMetric)
                const SizedBox(height: AppSpacing.xxs),
              Expanded(
                child: Center(
                  child: FittedBox(
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
