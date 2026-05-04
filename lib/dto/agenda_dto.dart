import '../domain/agenda_messages.dart';
import '../domain/agenda_overview.dart';
import '../domain/agenda_ui_labels.dart';
import '../domain/community_event.dart';
import '../domain/match_invite.dart';

class AgendaDto {
  AgendaDto({
    required this.payload,
  });

  factory AgendaDto.fromJson(Map<String, dynamic> json) {
    return AgendaDto(payload: json);
  }

  final Map<String, dynamic> payload;

  AgendaOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return AgendaOverview(
      title: payload['title'] as String,
      eventsTitle: payload['eventsTitle'] as String,
      matchesTitle: payload['matchesTitle'] as String,
      events: (payload['events'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => CommunityEvent(
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              tag: item['tag'] as String,
              imageAsset: item['imageAsset'] as String,
            ),
          )
          .toList(growable: false),
      matches: (payload['matches'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => MatchInvite(
              hostName: item['hostName'] as String,
              sport: item['sport'] as String,
              schedule: item['schedule'] as String,
              location: item['location'] as String,
              availability: item['availability'] as String,
              isLastSpot: item['isLastSpot'] as bool,
              avatarAsset: item['avatarAsset'] as String,
            ),
          )
          .toList(growable: false),
      uiLabels: AgendaUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
        eventBadgeLabel: uiLabels['eventBadgeLabel'] as String,
        matchBadgeLabel: uiLabels['matchBadgeLabel'] as String,
      ),
      messages: AgendaMessages(
        eventAction: messages['eventAction'] as String,
        matchAction: messages['matchAction'] as String,
      ),
    );
  }
}
