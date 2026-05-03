import 'package:flutter/material.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../../domain/quick_access_item.dart';
import '../../../components/section_header.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';
import 'home_cards_widgets.dart';
import 'home_dashboard_widgets.dart';
import 'home_quick_access_widgets.dart';
import 'home_top_widgets.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.overview,
    required this.onNotificationTap,
    required this.onBookingTap,
    required this.onAssistantTap,
    required this.onWorkoutTap,
    required this.onLessonsTap,
    required this.onAgendasTap,
    required this.onQuickAccessTap,
    required this.onMessage,
  });

  final DashboardOverview overview;
  final VoidCallback onNotificationTap;
  final VoidCallback onBookingTap;
  final VoidCallback onAssistantTap;
  final VoidCallback onWorkoutTap;
  final VoidCallback onLessonsTap;
  final VoidCallback onAgendasTap;
  final ValueChanged<QuickAccessItem> onQuickAccessTap;
  final ValueChanged<String> onMessage;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screen,
        topInset + AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.bottomContent,
      ),
      children: [
        HomeHeader(
          overview: overview,
          onNotificationTap: onNotificationTap,
        ),
        const SizedBox(height: AppSpacing.huge),
        HomeProgressBar(progress: overview.progress),
        const SizedBox(height: AppSpacing.xxxl),
        HomeBookingCard(
          overview: overview,
          onPressed: onBookingTap,
        ),
        const SizedBox(height: AppSpacing.huge),
        HomeAssistantCard(
          overview: overview,
          onTap: onAssistantTap,
        ),
        const SizedBox(height: AppSpacing.huge),
        HomeHeroCard(
          overview: overview,
          onPrimaryTap: () => onMessage(overview.messages.heroPrimaryAction),
          onSecondaryTap: () => onMessage(overview.messages.heroSecondaryAction),
        ),
        const SizedBox(height: AppSpacing.huge),
        HomeWorkoutCard(
          overview: overview,
          onTap: onWorkoutTap,
        ),
        const SizedBox(height: AppSpacing.section),
        SectionHeader(
          title: overview.sections.lessonsTitle,
          actionLabel: overview.sections.lessonsActionLabel,
          onActionTap: onLessonsTap,
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: compact
              ? AppSize.lessonListHeightCompact
              : AppSize.lessonListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: overview.lessons.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
            itemBuilder: (context, index) => HomeLessonCard(
              lesson: overview.lessons[index],
              aiBadgeLabel: overview.uiLabels.lessonAiBadge,
              onTap: onLessonsTap,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: overview.sections.leaderboardTitle,
          actionLabel: overview.sections.leaderboardActionLabel,
          onActionTap: () =>
              onMessage(overview.sections.leaderboardActionMessage),
        ),
        const SizedBox(height: AppSpacing.xl),
        HomeLeaderboardCard(overview: overview),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: overview.sections.exploreTitle,
          actionLabel: overview.sections.exploreActionLabel,
          onActionTap: onAgendasTap,
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: compact
              ? AppSize.exploreListHeightCompact
              : AppSize.exploreListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: overview.exploreEvents.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
            itemBuilder: (context, index) => HomeExploreCard(
              event: overview.exploreEvents[index],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: overview.sections.friendsTitle,
          actionLabel: overview.sections.friendsActionLabel,
          onActionTap: onAgendasTap,
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: compact
              ? AppSize.inviteListHeightCompact
              : AppSize.inviteListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: overview.matchInvites.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
            itemBuilder: (context, index) => HomeInviteCard(
              invite: overview.matchInvites[index],
              actionLabel: overview.uiLabels.inviteActionLabel,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: overview.sections.calendarTitle,
          actionLabel: overview.sections.calendarActionLabel,
          onActionTap: onAgendasTap,
        ),
        const SizedBox(height: AppSpacing.xl),
        HomeCalendarCard(overview: overview),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(title: overview.sections.quickAccessTitle),
        const SizedBox(height: AppSpacing.xl),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = (constraints.maxWidth - AppSpacing.xl) / 2;
            return Wrap(
              spacing: AppSpacing.xl,
              runSpacing: AppSpacing.xl,
              children: overview.quickAccessItems
                  .map(
                    (item) => SizedBox(
                      width: width,
                      child: HomeQuickAccessCard(
                        item: item,
                        onTap: () => onQuickAccessTap(item),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
        ),
      ],
    );
  }
}
