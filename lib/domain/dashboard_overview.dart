import 'app_user.dart';
import 'calendar_day.dart';
import 'community_event.dart';
import 'leaderboard_entry.dart';
import 'lesson.dart';
import 'match_invite.dart';
import 'quick_access_item.dart';

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
    required this.quickAccessItems,
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
  final List<QuickAccessItem> quickAccessItems;
}
