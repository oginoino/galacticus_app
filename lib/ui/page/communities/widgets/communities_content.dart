import 'package:flutter/material.dart';

import '../../../../domain/communities_overview.dart';
import '../../../theme/app_theme.dart';
import 'communities_club_widgets.dart';
import 'communities_top_widgets.dart';

class CommunitiesContent extends StatelessWidget {
  const CommunitiesContent({
    super.key,
    required this.overview,
    required this.onSearchTap,
    required this.onViewAllTap,
    required this.onFilterTap,
    required this.onJoinTap,
  });

  final CommunitiesOverview overview;
  final VoidCallback onSearchTap;
  final VoidCallback onViewAllTap;
  final VoidCallback onFilterTap;
  final VoidCallback onJoinTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screen,
        topInset + AppSpacing.page,
        AppSpacing.screen,
        AppSpacing.bottomContent,
      ),
      children: [
        CommunitiesHeader(overview: overview),
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
        UserClubsCarousel(clubs: overview.myClubs),
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
        ),
      ],
    );
  }
}
