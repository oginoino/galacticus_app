import 'package:flutter/material.dart';

import '../../../../domain/profile_overview.dart';
import '../../../../domain/profile_social_link.dart';
import '../../../theme/app_theme.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onMoreTap,
  });

  final ProfileOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return SizedBox(
      height: AppSize.profileHeroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            overview.heroImageAsset,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppPalette.black.withValues(alpha: AppOpacity.medium),
                    AppPalette.black.withValues(alpha: AppOpacity.scrim),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: topInset + AppSpacing.huge,
            left: AppInsets.profileHeroOverlay.left,
            right: AppInsets.profileHeroOverlay.right,
            child: Row(
              children: [
                _ProfileTopActionButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: onBackTap,
                ),
                const Spacer(),
                _ProfileTopActionButton(
                  icon: Icons.more_horiz_rounded,
                  onTap: onMoreTap,
                ),
              ],
            ),
          ),
          Positioned(
            left: AppInsets.profileHeroOverlay.left,
            right: AppInsets.profileHeroOverlay.right,
            bottom: AppInsets.profileHeroOverlay.bottom,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: AppSize.profileAvatarBorder,
                  height: AppSize.profileAvatarBorder,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppPalette.primary.withValues(alpha: AppOpacity.strong),
                      width: AppStroke.thick,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppSpacing.xxs),
                  child: Container(
                    width: AppSize.profileAvatar,
                    height: AppSize.profileAvatar,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(overview.avatarAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.giant),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              overview.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: AppPalette.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.displaySm,
                                    letterSpacing: AppLetterSpacing.tightMd,
                                  ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Icon(
                            Icons.verified_rounded,
                            color: AppPalette.primary,
                            size: AppSize.profileVerifiedIcon,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppPalette.textMuted,
                            size: AppIconSize.md,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              overview.clubLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppPalette.textMuted,
                                    fontSize: AppFontSize.titleSm,
                                  ),
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
        ],
      ),
    );
  }
}

class ProfileBadgeRow extends StatelessWidget {
  const ProfileBadgeRow({
    super.key,
    required this.overview,
  });

  final ProfileOverview overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.giant,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppPalette.primary,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            overview.levelLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.black,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
        ),
        const SizedBox(width: AppSpacing.giant),
        Text(
          overview.pointsLabel,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.title,
              ),
        ),
      ],
    );
  }
}

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.overview,
  });

  final ProfileOverview overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: overview.stats
          .map(
            (stat) => Expanded(
              child: Column(
                children: [
                  Text(
                    stat.value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.heading,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    stat.label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodyLg,
                        ),
                  ),
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class ProfileBio extends StatelessWidget {
  const ProfileBio({
    super.key,
    required this.overview,
  });

  final ProfileOverview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overview.bioLineOne,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.headingSm,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          overview.bioLineTwo,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.headingSm,
              ),
        ),
      ],
    );
  }
}

class ProfileSocialLinksRow extends StatelessWidget {
  const ProfileSocialLinksRow({
    super.key,
    required this.links,
    required this.onTap,
  });

  final List<ProfileSocialLink> links;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: links
          .map(
            (link) => Padding(
              padding: EdgeInsets.only(
                right: link == links.last ? 0 : AppSpacing.xl,
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  width: AppSize.profileSocialButton,
                  height: AppSize.profileSocialButton,
                  decoration: BoxDecoration(
                    color: AppPalette.surfaceAlt,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                      width: AppStroke.hairline,
                    ),
                  ),
                  child: Icon(
                    _iconForPlatform(link.icon),
                    color: AppPalette.textMuted,
                    size: AppIconSize.xxl,
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }

  IconData _iconForPlatform(String icon) {
    switch (icon) {
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'linkedin':
        return Icons.business_center_outlined;
      case 'x':
        return Icons.close_rounded;
      case 'whatsapp':
        return Icons.chat_bubble_outline_rounded;
      default:
        return Icons.link_rounded;
    }
  }
}

class ProfileTabsRow extends StatelessWidget {
  const ProfileTabsRow({
    super.key,
    required this.overview,
    required this.onTap,
  });

  final ProfileOverview overview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: overview.tabs
          .map(
            (tab) => Padding(
              padding: EdgeInsets.only(
                right: tab == overview.tabs.last ? 0 : AppSpacing.xl,
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  height: AppSize.profileTabHeight,
                  padding: AppInsets.profileTab,
                  decoration: BoxDecoration(
                    color: tab.isSelected ? AppPalette.white : AppPalette.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(
                      color: tab.isSelected
                          ? AppPalette.white
                          : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                      width: AppStroke.hairline,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tab.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: tab.isSelected
                              ? AppPalette.black
                              : AppPalette.textMuted,
                          fontWeight: tab.isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: AppFontSize.titleSm,
                        ),
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _ProfileTopActionButton extends StatelessWidget {
  const _ProfileTopActionButton({
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
      child: Container(
        width: AppSize.profileBackButton,
        height: AppSize.profileBackButton,
        decoration: BoxDecoration(
          color: AppPalette.black.withValues(alpha: AppOpacity.half),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppPalette.white,
          size: AppIconSize.huge,
        ),
      ),
    );
  }
}
