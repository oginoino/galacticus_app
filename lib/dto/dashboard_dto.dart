import '../domain/app_user.dart';
import '../domain/calendar_day.dart';
import '../domain/community_event.dart';
import '../domain/dashboard_overview.dart';
import '../domain/leaderboard_entry.dart';
import '../domain/lesson.dart';
import '../domain/match_invite.dart';
import '../domain/quick_access_item.dart';

class DashboardDto {
  DashboardDto({
    required this.payload,
  });

  factory DashboardDto.fromJson(Map<String, dynamic> json) {
    return DashboardDto(payload: json);
  }

  final Map<String, dynamic> payload;

  DashboardOverview toDomain() {
    final user = payload['user'] as Map<String, dynamic>;
    final booking = payload['booking'] as Map<String, dynamic>;
    final assistant = payload['assistant'] as Map<String, dynamic>;
    final hero = payload['hero'] as Map<String, dynamic>;
    final weeklyStats = payload['weeklyStats'] as Map<String, dynamic>;
    final calendar = payload['calendar'] as Map<String, dynamic>;

    return DashboardOverview(
      user: AppUser(
        name: user['name'] as String,
        levelLabel: user['levelLabel'] as String,
        pointsLabel: user['pointsLabel'] as String,
      ),
      progress: (payload['progress'] as num).toDouble(),
      locationLabel: payload['locationLabel'] as String,
      bookingVenue: booking['venue'] as String,
      bookingTime: booking['time'] as String,
      bookingCta: booking['cta'] as String,
      assistantLabel: assistant['label'] as String,
      assistantTitle: assistant['title'] as String,
      assistantSubtitle: assistant['subtitle'] as String,
      heroTitle: hero['title'] as String,
      heroSubtitle: hero['subtitle'] as String,
      primaryAction: hero['primaryAction'] as String,
      secondaryAction: hero['secondaryAction'] as String,
      lessons: _mapList(
        payload['lessons'] as List<dynamic>,
        (item) => Lesson(
          duration: item['duration'] as String,
          title: item['title'] as String,
          coach: item['coach'] as String,
          views: item['views'] as String,
          isAi: item['isAi'] as bool,
        ),
      ),
      leaderboard: _mapList(
        payload['leaderboard'] as List<dynamic>,
        (item) => LeaderboardEntry(
          position: item['position'] as int,
          name: item['name'] as String,
          points: item['points'] as String,
          isCurrentUser: item['isCurrentUser'] as bool,
        ),
      ),
      weeklyHeadline: weeklyStats['headline'] as String,
      weeklyTrainings: weeklyStats['trainings'] as String,
      weeklyVariation: weeklyStats['variation'] as String,
      totalTime: weeklyStats['time'] as String,
      calories: weeklyStats['calories'] as String,
      consistency: weeklyStats['consistency'] as String,
      exploreEvents: _mapList(
        payload['exploreEvents'] as List<dynamic>,
        (item) => CommunityEvent(
          title: item['title'] as String,
          subtitle: item['subtitle'] as String,
          tag: item['tag'] as String,
        ),
      ),
      matchInvites: _mapList(
        payload['matchInvites'] as List<dynamic>,
        (item) => MatchInvite(
          hostName: item['hostName'] as String,
          sport: item['sport'] as String,
          schedule: item['schedule'] as String,
          location: item['location'] as String,
          availability: item['availability'] as String,
          isLastSpot: item['isLastSpot'] as bool,
        ),
      ),
      calendarMonthLabel: calendar['monthLabel'] as String,
      calendarDays: _mapList(
        calendar['days'] as List<dynamic>,
        (item) => CalendarDay(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
          isActive: item['isActive'] as bool,
        ),
      ),
      quickAccessItems: _mapList(
        payload['quickAccess'] as List<dynamic>,
        (item) => QuickAccessItem(
          title: item['title'] as String,
          subtitle: item['subtitle'] as String,
          accentLabel: item['accentLabel'] as String,
          icon: item['icon'] as String,
        ),
      ),
    );
  }

  List<T> _mapList<T>(
    List<dynamic> source,
    T Function(Map<String, dynamic> json) mapper,
  ) {
    return source
        .cast<Map<String, dynamic>>()
        .map(mapper)
        .toList(growable: false);
  }
}
