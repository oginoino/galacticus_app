import '../domain/app_user.dart';
import '../domain/calendar_day.dart';
import '../domain/calendar_event.dart';
import '../domain/community_event.dart';
import '../domain/dashboard_overview.dart';
import '../domain/home_messages.dart';
import '../domain/home_sections.dart';
import '../domain/home_ui_labels.dart';
import '../domain/leaderboard_entry.dart';
import '../domain/lesson.dart';
import '../domain/match_invite.dart';
import '../domain/quick_access_item.dart';
import '../domain/workout_promo.dart';

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
    final sections = payload['sections'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;
    final workoutPromo = payload['workoutPromo'] as Map<String, dynamic>;
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final assets = payload['assets'] as Map<String, dynamic>;

    return DashboardOverview(
      user: AppUser(
        name: user['name'] as String,
        levelLabel: user['levelLabel'] as String,
        pointsLabel: user['pointsLabel'] as String,
        avatarAsset: user['avatarAsset'] as String,
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
      heroSuggestedTrainingId: hero['suggestedTrainingId'] as String?,
      lessons: _mapList(
        payload['lessons'] as List<dynamic>,
        (item) => Lesson(
          duration: item['duration'] as String,
          title: item['title'] as String,
          coach: item['coach'] as String,
          views: item['views'] as String,
          isAi: item['isAi'] as bool,
          imageAsset: item['imageAsset'] as String,
        ),
      ),
      leaderboard: _mapList(
        payload['leaderboard'] as List<dynamic>,
        (item) => LeaderboardEntry(
          position: item['position'] as int,
          name: item['name'] as String,
          points: item['points'] as String,
          isCurrentUser: item['isCurrentUser'] as bool,
          avatarAsset: item['avatarAsset'] as String,
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
          imageAsset: item['imageAsset'] as String,
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
          avatarAsset: item['avatarAsset'] as String,
        ),
      ),
      calendarMonthLabel: calendar['monthLabel'] as String,
      calendarDays: _mapList(
        calendar['days'] as List<dynamic>,
        (item) => CalendarDay(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
          isActive: item['isActive'] as bool,
          imageAsset: item['imageAsset'] as String?,
          event: _parseCalendarEvent(item['event']),
        ),
      ),
      calendarWeekdays: (calendar['weekdays'] as List<dynamic>)
          .cast<String>()
          .toList(growable: false),
      chartWeekdays: (weeklyStats['weekdays'] as List<dynamic>)
          .cast<String>()
          .toList(growable: false),
      quickAccessItems: _mapList(
        payload['quickAccess'] as List<dynamic>,
        (item) => QuickAccessItem(
          title: item['title'] as String,
          subtitle: item['subtitle'] as String,
          accentLabel: item['accentLabel'] as String,
          icon: item['icon'] as String,
          type: item['type'] as String,
          backgroundAsset: item['backgroundAsset'] as String,
          content: Map<String, dynamic>.from(item['content'] as Map),
        ),
      ),
      sections: HomeSections(
        lessonsTitle: sections['lessonsTitle'] as String,
        lessonsActionLabel: sections['lessonsActionLabel'] as String,
        lessonsActionMessage: sections['lessonsActionMessage'] as String,
        leaderboardTitle: sections['leaderboardTitle'] as String,
        leaderboardActionLabel: sections['leaderboardActionLabel'] as String,
        leaderboardActionMessage: sections['leaderboardActionMessage'] as String,
        exploreTitle: sections['exploreTitle'] as String,
        exploreActionLabel: sections['exploreActionLabel'] as String,
        exploreActionMessage: sections['exploreActionMessage'] as String,
        friendsTitle: sections['friendsTitle'] as String,
        friendsActionLabel: sections['friendsActionLabel'] as String,
        friendsActionMessage: sections['friendsActionMessage'] as String,
        calendarTitle: sections['calendarTitle'] as String,
        calendarActionLabel: sections['calendarActionLabel'] as String,
        calendarActionMessage: sections['calendarActionMessage'] as String,
        quickAccessTitle: sections['quickAccessTitle'] as String,
      ),
      messages: HomeMessages(
        bookingAction: messages['bookingAction'] as String,
        heroPrimaryAction: messages['heroPrimaryAction'] as String,
        heroSecondaryAction: messages['heroSecondaryAction'] as String,
        quickAction: messages['quickAction'] as String,
      ),
      workoutPromo: WorkoutPromo(
        title: workoutPromo['title'] as String,
        subtitle: workoutPromo['subtitle'] as String,
      ),
      uiLabels: HomeUiLabels(
        lessonAiBadge: uiLabels['lessonAiBadge'] as String,
        inviteActionLabel: uiLabels['inviteActionLabel'] as String,
        leaderboardCurrentUserLabel:
            uiLabels['leaderboardCurrentUserLabel'] as String,
        leaderboardPositionPrefix:
            uiLabels['leaderboardPositionPrefix'] as String,
        weeklyTimeLabel: uiLabels['weeklyTimeLabel'] as String,
        weeklyCaloriesLabel: uiLabels['weeklyCaloriesLabel'] as String,
        weeklyConsistencyLabel:
            uiLabels['weeklyConsistencyLabel'] as String,
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      assistantLogoAsset: assets['assistantLogoAsset'] as String,
      heroImageAsset: assets['heroImageAsset'] as String,
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

  CalendarEvent? _parseCalendarEvent(Object? value) {
    if (value is! Map) return null;
    final map = value.cast<String, dynamic>();
    return CalendarEvent(
      type: map['type'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      referenceId: map['referenceId'] as String?,
    );
  }
}
