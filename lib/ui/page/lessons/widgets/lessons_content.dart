import 'package:flutter/material.dart';

import '../../../../domain/lessons_overview.dart';
import '../../../theme/app_theme.dart';
import 'lessons_widgets.dart';

class LessonsContent extends StatelessWidget {
  const LessonsContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onFeaturedTap,
    required this.onTrackTap,
    required this.onUpcomingTap,
  });

  final LessonsOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onFeaturedTap;
  final VoidCallback onTrackTap;
  final VoidCallback onUpcomingTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: AppInsets.lessonsPage,
      children: [
        LessonsHeader(
          title: overview.title,
          onBackTap: onBackTap,
        ),
        LessonsFeaturedHero(
          overview: overview,
          aiBadgeLabel: overview.uiLabels.aiBadgeLabel,
          onPrimaryTap: onFeaturedTap,
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        LessonsSectionTitle(title: overview.movementsTitle),
        const SizedBox(height: AppSpacing.xl),
        LessonsTrackList(
          items: overview.tracks,
          aiBadgeLabel: overview.uiLabels.aiBadgeLabel,
          trainLabel: overview.uiLabels.trainLabel,
          onTap: onTrackTap,
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        LessonsSectionTitle(title: overview.upcomingTitle),
        const SizedBox(height: AppSpacing.xl),
        LessonsUpcomingList(
          items: overview.upcomingItems,
          onTap: onUpcomingTap,
        ),
      ],
    );
  }
}
