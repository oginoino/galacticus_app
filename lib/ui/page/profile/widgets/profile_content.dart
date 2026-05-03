import 'package:flutter/material.dart';

import '../../../../domain/profile_overview.dart';
import '../../../theme/app_theme.dart';
import 'profile_gallery_widgets.dart';
import 'profile_top_widgets.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onMoreTap,
    required this.onSocialTap,
    required this.onTabTap,
    required this.onGalleryTap,
  });

  final ProfileOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onMoreTap;
  final VoidCallback onSocialTap;
  final VoidCallback onTabTap;
  final VoidCallback onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.zero,
      children: [
        ProfileHero(
          overview: overview,
          onBackTap: onBackTap,
          onMoreTap: onMoreTap,
        ),
        Padding(
          padding: AppInsets.profileContent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileBadgeRow(overview: overview),
              const SizedBox(height: AppSpacing.page),
              ProfileStatsRow(overview: overview),
              const SizedBox(height: AppSpacing.section),
              ProfileBio(overview: overview),
              const SizedBox(height: AppSpacing.page),
              ProfileSocialLinksRow(
                links: overview.socialLinks,
                onTap: onSocialTap,
              ),
              const SizedBox(height: AppSpacing.page),
              ProfileTabsRow(
                overview: overview,
                onTap: onTabTap,
              ),
              const SizedBox(height: AppSpacing.page),
              ProfileGalleryGrid(
                items: overview.galleryItems,
                onTap: onGalleryTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
