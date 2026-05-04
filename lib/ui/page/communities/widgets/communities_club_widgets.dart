import 'package:flutter/material.dart';

import '../../../../domain/discover_club.dart';
import '../../../../domain/user_club.dart';
import '../../../theme/app_theme.dart';

class UserClubsCarousel extends StatelessWidget {
  const UserClubsCarousel({
    super.key,
    required this.clubs,
    required this.onClubTap,
  });

  final List<UserClub> clubs;
  final ValueChanged<UserClub> onClubTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.communitiesOwnedListHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: clubs.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
        itemBuilder: (context, index) => UserClubCard(
          club: clubs[index],
          onTap: () => onClubTap(clubs[index]),
        ),
      ),
    );
  }
}

class UserClubCard extends StatelessWidget {
  const UserClubCard({
    super.key,
    required this.club,
    required this.onTap,
  });

  final UserClub club;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        width: AppSize.communitiesOwnedCardWidth,
        height: AppSize.communitiesOwnedCardHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              club.imageAsset,
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
                      AppPalette.black.withValues(alpha: AppOpacity.scrim),
                    ],
                    stops: const [0.42, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppInsets.communitiesOwnedCardOverlay.left,
              right: AppInsets.communitiesOwnedCardOverlay.right,
              bottom: AppInsets.communitiesOwnedCardOverlay.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppPalette.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.titleLg,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    club.membersLabel,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodySm,
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

class DiscoverClubsGrid extends StatelessWidget {
  const DiscoverClubsGrid({
    super.key,
    required this.clubs,
    required this.onJoinTap,
    required this.onClubTap,
  });

  final List<DiscoverClub> clubs;
  final VoidCallback onJoinTap;
  final ValueChanged<DiscoverClub> onClubTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: clubs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.giant,
        crossAxisSpacing: AppSpacing.giant,
        childAspectRatio: AppSize.communitiesDiscoverGridAspectRatio,
      ),
      itemBuilder: (context, index) {
        return DiscoverClubCard(
          club: clubs[index],
          onJoinTap: onJoinTap,
          onTap: () => onClubTap(clubs[index]),
        );
      },
    );
  }
}

class DiscoverClubCard extends StatelessWidget {
  const DiscoverClubCard({
    super.key,
    required this.club,
    required this.onJoinTap,
    required this.onTap,
  });

  final DiscoverClub club;
  final VoidCallback onJoinTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.communitiesDiscoverCardRadius),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppPalette.surface,
          borderRadius: BorderRadius.circular(AppSize.communitiesDiscoverCardRadius),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.communitiesDiscoverImageHeight,
              width: double.infinity,
              child: Image.asset(
                club.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxHeight < 156;

                  return Padding(
                    padding: isCompact
                        ? AppInsets.communitiesDiscoverCardBodyCompact
                        : AppInsets.communitiesDiscoverCardBody,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          club.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: isCompact
                                    ? AppFontSize.title
                                    : AppFontSize.titleLg,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          club.tagsLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppPalette.textDim,
                                fontSize: AppFontSize.bodySm,
                              ),
                        ),
                        SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
                        Flexible(
                          child: Text(
                            club.subtitle,
                            maxLines: isCompact ? 1 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppPalette.textMuted,
                                  fontSize: isCompact
                                      ? AppFontSize.body
                                      : AppFontSize.bodyLg,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ),
                        SizedBox(height: isCompact ? AppSpacing.md : AppSpacing.giant),
                        Row(
                          children: [
                            _MemberAvatars(avatarAssets: club.memberAvatarAssets),
                            const Spacer(),
                            Flexible(
                              child: Text(
                                club.membersLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppPalette.textMuted,
                                      fontSize: AppFontSize.bodySm,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isCompact ? AppSpacing.md : AppSpacing.xl),
                        InkWell(
                          onTap: onJoinTap,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          child: Container(
                            height: isCompact
                                ? AppSize.communitiesDiscoverButtonHeightCompact
                                : AppSize.communitiesDiscoverButtonHeight,
                            decoration: BoxDecoration(
                              color: AppPalette.surfaceAlt,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                              border: Border.all(
                                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                                width: AppStroke.hairline,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              club.joinLabel,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPalette.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.titleSm,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberAvatars extends StatelessWidget {
  const _MemberAvatars({
    required this.avatarAssets,
  });

  final List<String> avatarAssets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.communitiesDiscoverAvatar +
          ((avatarAssets.length - 1) * AppSpacing.xl),
      height: AppSize.communitiesDiscoverAvatar,
      child: Stack(
        children: avatarAssets.asMap().entries.map((entry) {
          final index = entry.key;
          final avatarAsset = entry.value;

          return Positioned(
            left: index * AppSpacing.xl,
            child: Container(
              width: AppSize.communitiesDiscoverAvatar,
              height: AppSize.communitiesDiscoverAvatar,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppPalette.surface,
                  width: AppStroke.thin,
                ),
                image: DecorationImage(
                  image: AssetImage(avatarAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }
}
