import 'agenda_messages.dart';
import 'agenda_ui_labels.dart';
import 'community_event.dart';
import 'match_invite.dart';

class AgendaOverview {
  const AgendaOverview({
    required this.title,
    required this.eventsTitle,
    required this.matchesTitle,
    required this.events,
    required this.matches,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final String eventsTitle;
  final String matchesTitle;
  final List<CommunityEvent> events;
  final List<MatchInvite> matches;
  final AgendaUiLabels uiLabels;
  final AgendaMessages messages;
}
