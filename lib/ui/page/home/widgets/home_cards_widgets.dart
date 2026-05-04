import 'package:flutter/material.dart';

import '../../../../domain/community_event.dart';
import '../../../../domain/lesson.dart';
import '../../../../domain/match_invite.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';

class HomeLessonCard extends StatelessWidget {
  const HomeLessonCard({
    super.key,
    required this.lesson,
    required this.aiBadgeLabel,
    required this.onTap,
  });

  final Lesson lesson;
  final String aiBadgeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      width: compact ? AppSize.lessonCardWidthCompact : AppSize.lessonCardWidth,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Container(
          decoration: BoxDecoration(
            color: AppPalette.surfaceDeep,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.sm),
              width: AppStroke.hairline,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.xl),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(lesson.imageAsset, fit: BoxFit.cover),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppPalette.black.withValues(alpha: AppOpacity.rich),
                              AppPalette.black.withValues(alpha: AppOpacity.lg),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: AppSpacing.md,
                        left: AppSpacing.md,
                        child: lesson.isAi
                            ? HomeMiniBadge(
                                label: aiBadgeLabel,
                                icon: Icons.trending_up_rounded,
                                highlighted: true,
                              )
                            : const SizedBox.shrink(),
                      ),
                      Center(
                        child: Container(
                          width: compact ? 46 : 52,
                          height: compact ? 46 : 52,
                          decoration: const BoxDecoration(
                            color: AppPalette.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: AppPalette.black,
                            size: compact
                                ? AppIconSize.giantPlus
                                : AppIconSize.play,
                          ),
                        ),
                      ),
                      Positioned(
                        right: AppSpacing.md,
                        bottom: AppSpacing.md,
                        child: HomeDurationBadge(label: lesson.duration),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            fontSize: compact ? AppFontSize.bodyLg : AppFontSize.title,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lesson.coach,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textTertiary,
                                  fontSize: compact
                                      ? AppFontSize.bodySm
                                      : AppFontSize.body,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          lesson.views,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppPalette.textTertiary,
                                fontSize: compact
                                    ? AppFontSize.labelLg
                                    : AppFontSize.bodySm,
                              ),
                        ),
                      ],
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

class HomeExploreCard extends StatelessWidget {
  const HomeExploreCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  final CommunityEvent event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.exploreCardWidth,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(event.imageAsset, fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.lg),
                      AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: AppLetterSpacing.tightMd,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      event.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppPalette.textEvent,
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

class HomeInviteCard extends StatelessWidget {
  const HomeInviteCard({
    super.key,
    required this.invite,
    required this.actionLabel,
    required this.onTap,
  });

  final MatchInvite invite;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      width: compact ? AppSize.inviteCardWidthCompact : AppSize.inviteCardWidth,
      child: GlowCard(
        onTap: onTap,
        padding: EdgeInsets.fromLTRB(
          compact ? AppSpacing.lg : AppSpacing.xl,
          compact ? AppSpacing.lg : AppSpacing.xl,
          compact ? AppSpacing.lg : AppSpacing.xl,
          compact ? AppSpacing.md : AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: compact ? 18 : 22,
                  backgroundImage: AssetImage(invite.avatarAsset),
                ),
                SizedBox(width: compact ? AppSpacing.md : AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        invite.hostName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: AppLetterSpacing.tightSm,
                              fontSize: compact
                                  ? AppFontSize.title
                                  : AppFontSize.titleLg,
                            ),
                      ),
                      Text(
                        invite.sport,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppPalette.textGlass,
                              fontSize: compact
                                  ? AppFontSize.bodySm
                                  : AppFontSize.body,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            HomeMetaRow(
              icon: Icons.access_time_rounded,
              text: invite.schedule,
            ),
            SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            HomeMetaRow(
              icon: Icons.location_on_outlined,
              text: invite.location,
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: invite.isLastSpot
                          ? AppPalette.warningDark
                          : AppPalette.successDark,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Text(
                      invite.availability,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: invite.isLastSpot
                                ? AppPalette.warning
                                : AppPalette.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: compact
                                ? AppFontSize.caption
                                : AppFontSize.bodySm,
                          ),
                    ),
                  ),
                ),
                SizedBox(width: compact ? AppSpacing.sm : AppSpacing.md),
                Text(
                  actionLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: compact
                            ? AppFontSize.caption
                            : AppFontSize.bodySm,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMiniBadge extends StatelessWidget {
  const HomeMiniBadge({
    super.key,
    required this.label,
    required this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.primary : AppPalette.glassBorder,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppIconSize.xs,
            color: AppPalette.black,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: const TextStyle(
              color: AppPalette.black,
              fontSize: AppFontSize.label,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDurationBadge extends StatelessWidget {
  const HomeDurationBadge({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.scrim),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppPalette.white,
          fontSize: AppFontSize.labelLg,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class HomeMetaRow extends StatelessWidget {
  const HomeMetaRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return Row(
      children: [
        Icon(
          icon,
          size: compact ? AppIconSize.sm : AppIconSize.md,
          color: AppPalette.textMeta,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.textQuaternary,
                  fontSize: compact ? AppFontSize.bodySm : AppFontSize.bodyLg,
                ),
          ),
        ),
      ],
    );
  }
}
