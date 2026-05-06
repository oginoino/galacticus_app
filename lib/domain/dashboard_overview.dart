import 'app_user.dart';
import 'calendar_day.dart';
import 'community_event.dart';
import 'home_messages.dart';
import 'home_sections.dart';
import 'home_ui_labels.dart';
import 'leaderboard_entry.dart';
import 'lesson.dart';
import 'match_invite.dart';
import 'quick_access_item.dart';
import 'workout_promo.dart';

class DashboardOverview {
  const DashboardOverview({
    required this.user,
    required this.progress,
    required this.locationLabel,
    required this.bookingVenue,
    required this.bookingTime,
    required this.bookingCta,
    required this.assistantLabel,
    required this.assistantTitle,
    required this.assistantSubtitle,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.primaryAction,
    required this.secondaryAction,
    this.heroSuggestedTrainingId,
    required this.lessons,
    required this.leaderboard,
    required this.weeklyHeadline,
    required this.weeklyTrainings,
    required this.weeklyVariation,
    required this.totalTime,
    required this.calories,
    required this.consistency,
    required this.exploreEvents,
    required this.matchInvites,
    required this.calendarMonthLabel,
    required this.calendarDays,
    required this.calendarWeekdays,
    required this.chartWeekdays,
    required this.quickAccessItems,
    required this.sections,
    required this.messages,
    required this.workoutPromo,
    required this.uiLabels,
    required this.assistantLogoAsset,
    required this.heroImageAsset,
  });

  final AppUser user;
  final double progress;
  final String locationLabel;
  final String bookingVenue;
  final String bookingTime;
  final String bookingCta;
  final String assistantLabel;
  final String assistantTitle;
  final String assistantSubtitle;
  final String heroTitle;
  final String heroSubtitle;
  final String primaryAction;
  final String secondaryAction;
  final String? heroSuggestedTrainingId;
  final List<Lesson> lessons;
  final List<LeaderboardEntry> leaderboard;
  final String weeklyHeadline;
  final String weeklyTrainings;
  final String weeklyVariation;
  final String totalTime;
  final String calories;
  final String consistency;
  final List<CommunityEvent> exploreEvents;
  final List<MatchInvite> matchInvites;
  final String calendarMonthLabel;
  final List<CalendarDay> calendarDays;
  final List<String> calendarWeekdays;
  final List<String> chartWeekdays;
  final List<QuickAccessItem> quickAccessItems;
  final HomeSections sections;
  final HomeMessages messages;
  final WorkoutPromo workoutPromo;
  final HomeUiLabels uiLabels;
  final String assistantLogoAsset;
  final String heroImageAsset;
}
