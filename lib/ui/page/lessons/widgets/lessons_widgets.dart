import 'package:flutter/material.dart';

import '../../../../domain/lessons_overview.dart';
import '../../../../domain/lessons_track.dart';
import '../../../../domain/lessons_upcoming_item.dart';
import '../../../theme/app_theme.dart';

class LessonsFeaturedHero extends StatelessWidget {
  const LessonsFeaturedHero({
    super.key,
    required this.overview,
    required this.aiBadgeLabel,
    required this.onPrimaryTap,
  });

  final LessonsOverview overview;
  final String aiBadgeLabel;
  final VoidCallback onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.lessonsHeroHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  overview.featuredImageAsset,
                  fit: BoxFit.cover,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppPalette.black.withValues(alpha: AppOpacity.lg),
                        AppPalette.black.withValues(alpha: AppOpacity.overlay),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.xl,
                  right: AppSpacing.xl,
                  child: LessonsDurationChip(label: overview.featuredDuration),
                ),
                Center(
                  child: Container(
                    width: AppSize.lessonsFeaturedPlay,
                    height: AppSize.lessonsFeaturedPlay,
                    decoration: const BoxDecoration(
                      color: AppPalette.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: AppPalette.black,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _LessonsBadge(
              label: overview.featuredTagPrimary,
              highlighted: true,
            ),
            _LessonsBadge(
              label: overview.featuredTagSecondary,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          overview.featuredTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.heading,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          overview.featuredMetricsLine,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.bodySm,
              ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            CircleAvatar(
              radius: AppSize.lessonsCoachAvatarRadius,
              backgroundImage: AssetImage(overview.featuredCoachAvatarAsset),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overview.featuredCoach,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.bodyLg,
                        ),
                  ),
                  Text(
                    overview.featuredCoachRole,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodySm,
                        ),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: onPrimaryTap,
              style: FilledButton.styleFrom(
                backgroundColor: AppPalette.primary,
                foregroundColor: AppPalette.black,
                minimumSize: const Size(0, AppSize.buttonHeightCompact),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
              ),
              icon: const Icon(
                Icons.videocam_outlined,
                size: AppIconSize.md,
              ),
              label: Text(
                overview.featuredCtaLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.bodySm,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          overview.featuredDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.body,
                height: 1.4,
              ),
        ),
      ],
    );
  }
}

class LessonsSectionTitle extends StatelessWidget {
  const LessonsSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: AppFontSize.title,
          ),
    );
  }
}

class LessonsTrackList extends StatelessWidget {
  const LessonsTrackList({
    super.key,
    required this.items,
    required this.aiBadgeLabel,
    required this.trainLabel,
    required this.onTap,
  });

  final List<LessonsTrack> items;
  final String aiBadgeLabel;
  final String trainLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.lessonsTrackCardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
        itemBuilder: (context, index) => _LessonsTrackCard(
          item: items[index],
          aiBadgeLabel: aiBadgeLabel,
          trainLabel: trainLabel,
          onTap: onTap,
        ),
      ),
    );
  }
}

class LessonsUpcomingList extends StatelessWidget {
  const LessonsUpcomingList({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<LessonsUpcomingItem> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: AppResponsiveInsets.listItemGap(item == items.last),
              child: _LessonsUpcomingCard(
                item: item,
                onTap: onTap,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _LessonsTrackCard extends StatelessWidget {
  const _LessonsTrackCard({
    required this.item,
    required this.aiBadgeLabel,
    required this.trainLabel,
    required this.onTap,
  });

  final LessonsTrack item;
  final String aiBadgeLabel;
  final String trainLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: SizedBox(
        width: AppSize.lessonsTrackCardWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(item.imageAsset, fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.45, 1.0],
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.sm),
                      AppPalette.black.withValues(alpha: AppOpacity.lg),
                      AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: AppInsets.cardPaddingMd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (item.isAi)
                          _LessonsBadge(
                            label: aiBadgeLabel,
                            highlighted: true,
                          ),
                        const Spacer(),
                        _LessonsBadge(label: item.levelLabel),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.title,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppPalette.textMuted,
                            fontSize: AppFontSize.bodySm,
                            height: 1.25,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: AppInsets.actionChipPadding,
                      decoration: BoxDecoration(
                        color: AppPalette.primary,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.videocam_outlined,
                            color: AppPalette.black,
                            size: AppIconSize.md,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            trainLabel,
                            style: const TextStyle(
                              color: AppPalette.black,
                              fontWeight: FontWeight.w700,
                              fontSize: AppFontSize.bodySm,
                            ),
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
      ),
    );
  }
}

class _LessonsUpcomingCard extends StatelessWidget {
  const _LessonsUpcomingCard({
    required this.item,
    required this.onTap,
  });

  final LessonsUpcomingItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: AppInsets.cardPaddingSm,
        decoration: BoxDecoration(
          color: AppPalette.surfaceDeep,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Image.asset(
                    item.imageAsset,
                    width: AppSize.lessonsUpcomingThumbWidth,
                    height: AppSize.lessonsUpcomingThumbHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: AppSize.lessonsUpcomingPlayButton,
                      height: AppSize.lessonsUpcomingPlayButton,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: AppPalette.black,
                        size: AppIconSize.giant,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: AppSpacing.sm,
                  bottom: AppSpacing.sm,
                  child: LessonsDurationChip(label: item.duration),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.titleSm,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.coach,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodySm,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.metaLine,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodySm,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _AvailabilityTag(label: item.availabilityLabel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonsBadge extends StatelessWidget {
  const _LessonsBadge({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.pillPadding,
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.primary : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppPalette.black : AppPalette.white,
          fontWeight: FontWeight.w700,
          fontSize: AppFontSize.labelLg,
        ),
      ),
    );
  }
}

class _AvailabilityTag extends StatelessWidget {
  const _AvailabilityTag({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.pillPadding,
      decoration: BoxDecoration(
        color: AppPalette.primary.withValues(alpha: AppOpacity.xs),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppPalette.primary,
          fontWeight: FontWeight.w700,
          fontSize: AppFontSize.labelLg,
        ),
      ),
    );
  }
}

class LessonsDurationChip extends StatelessWidget {
  const LessonsDurationChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.pillPadding,
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.schedule_rounded,
            size: AppIconSize.xs,
            color: AppPalette.white,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: const TextStyle(
              color: AppPalette.white,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.labelLg,
            ),
          ),
        ],
      ),
    );
  }
}
