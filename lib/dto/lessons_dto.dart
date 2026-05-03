import '../domain/lessons_messages.dart';
import '../domain/lessons_overview.dart';
import '../domain/lessons_track.dart';
import '../domain/lessons_ui_labels.dart';
import '../domain/lessons_upcoming_item.dart';

class LessonsDto {
  LessonsDto({
    required this.payload,
  });

  factory LessonsDto.fromJson(Map<String, dynamic> json) {
    return LessonsDto(payload: json);
  }

  final Map<String, dynamic> payload;

  LessonsOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return LessonsOverview(
      title: payload['title'] as String,
      featuredTagPrimary: payload['featuredTagPrimary'] as String,
      featuredTagSecondary: payload['featuredTagSecondary'] as String,
      featuredTitle: payload['featuredTitle'] as String,
      featuredMetricsLine: payload['featuredMetricsLine'] as String,
      featuredCoach: payload['featuredCoach'] as String,
      featuredCoachAvatarAsset: payload['featuredCoachAvatarAsset'] as String,
      featuredCoachRole: payload['featuredCoachRole'] as String,
      featuredDescription: payload['featuredDescription'] as String,
      featuredCtaLabel: payload['featuredCtaLabel'] as String,
      featuredImageAsset: payload['featuredImageAsset'] as String,
      featuredDuration: payload['featuredDuration'] as String,
      movementsTitle: payload['movementsTitle'] as String,
      upcomingTitle: payload['upcomingTitle'] as String,
      tracks: (payload['tracks'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => LessonsTrack(
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              levelLabel: item['levelLabel'] as String,
              isAi: item['isAi'] as bool,
              imageAsset: item['imageAsset'] as String,
            ),
          )
          .toList(growable: false),
      upcomingItems: (payload['upcomingItems'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => LessonsUpcomingItem(
              title: item['title'] as String,
              coach: item['coach'] as String,
              metaLine: item['metaLine'] as String,
              duration: item['duration'] as String,
              availabilityLabel: item['availabilityLabel'] as String,
              imageAsset: item['imageAsset'] as String,
            ),
          )
          .toList(growable: false),
      uiLabels: LessonsUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
        aiBadgeLabel: uiLabels['aiBadgeLabel'] as String,
        trainLabel: uiLabels['trainLabel'] as String,
      ),
      messages: LessonsMessages(
        featuredAction: messages['featuredAction'] as String,
        trackAction: messages['trackAction'] as String,
        upcomingAction: messages['upcomingAction'] as String,
      ),
    );
  }
}
