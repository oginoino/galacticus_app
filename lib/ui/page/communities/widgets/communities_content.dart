import 'package:flutter/material.dart';

import '../../../../domain/discover_club.dart';
import '../../../../domain/communities_overview.dart';
import '../../../../domain/user_club.dart';
import '../../../theme/app_theme.dart';
import 'communities_club_widgets.dart';
import 'communities_top_widgets.dart';

class CommunitiesContent extends StatelessWidget {
  const CommunitiesContent({
    super.key,
    required this.overview,
    required this.onNotificationTap,
    required this.onSearchTap,
    required this.onViewAllTap,
    required this.onFilterTap,
    required this.onJoinTap,
    required this.onUserClubTap,
    required this.onDiscoverClubTap,
  });

  final CommunitiesOverview overview;
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;
  final VoidCallback onViewAllTap;
  final VoidCallback onFilterTap;
  final VoidCallback onJoinTap;
  final ValueChanged<UserClub> onUserClubTap;
  final ValueChanged<DiscoverClub> onDiscoverClubTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Column(
      children: [
        Padding(
          padding: AppResponsiveInsets.screenTopBar(
            topInset,
            extraTop: AppSpacing.page,
          ),
          child: CommunitiesHeader(
            overview: overview,
            onNotificationTap: onNotificationTap,
          ),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: AppInsets.communitiesPage,
            children: [
              const SizedBox(height: AppSpacing.page),
              CommunitiesSearchBar(
                placeholder: overview.searchPlaceholder,
                onTap: onSearchTap,
              ),
              const SizedBox(height: AppSpacing.page),
              CommunitiesSectionHeader(
                title: overview.myClubsTitle,
                actionLabel: overview.viewAllLabel,
                onActionTap: onViewAllTap,
              ),
              const SizedBox(height: AppSpacing.giant),
              UserClubsCarousel(
                clubs: overview.myClubs,
                onClubTap: onUserClubTap,
              ),
              const SizedBox(height: AppSpacing.page),
              Container(
                height: AppSize.communitiesSectionDivider,
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
              ),
              const SizedBox(height: AppSpacing.page),
              CommunitiesSectionHeader(
                title: overview.discoverTitle,
              ),
              const SizedBox(height: AppSpacing.page),
              CommunitiesCategoryChips(
                overview: overview,
                onFilterTap: onFilterTap,
              ),
              const SizedBox(height: AppSpacing.page),
              DiscoverClubsGrid(
                clubs: overview.discoverClubs,
                onJoinTap: onJoinTap,
                onClubTap: onDiscoverClubTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
