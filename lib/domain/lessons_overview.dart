import 'lessons_messages.dart';
import 'lessons_track.dart';
import 'lessons_ui_labels.dart';
import 'lessons_upcoming_item.dart';

class LessonsOverview {
  const LessonsOverview({
    required this.title,
    required this.featuredTagPrimary,
    required this.featuredTagSecondary,
    required this.featuredTitle,
    required this.featuredMetricsLine,
    required this.featuredCoach,
    required this.featuredCoachAvatarAsset,
    required this.featuredCoachRole,
    required this.featuredDescription,
    required this.featuredCtaLabel,
    required this.featuredImageAsset,
    required this.featuredDuration,
    required this.movementsTitle,
    required this.upcomingTitle,
    required this.tracks,
    required this.upcomingItems,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final String featuredTagPrimary;
  final String featuredTagSecondary;
  final String featuredTitle;
  final String featuredMetricsLine;
  final String featuredCoach;
  final String featuredCoachAvatarAsset;
  final String featuredCoachRole;
  final String featuredDescription;
  final String featuredCtaLabel;
  final String featuredImageAsset;
  final String featuredDuration;
  final String movementsTitle;
  final String upcomingTitle;
  final List<LessonsTrack> tracks;
  final List<LessonsUpcomingItem> upcomingItems;
  final LessonsUiLabels uiLabels;
  final LessonsMessages messages;
}
