import '../domain/ranking_category.dart';
import '../domain/ranking_list_entry.dart';
import '../domain/ranking_messages.dart';
import '../domain/ranking_overview.dart';
import '../domain/ranking_podium_entry.dart';
import '../domain/ranking_ui_labels.dart';

class RankingDto {
  RankingDto({
    required this.payload,
  });

  factory RankingDto.fromJson(Map<String, dynamic> json) {
    return RankingDto(payload: json);
  }

  final Map<String, dynamic> payload;

  RankingOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return RankingOverview(
      title: payload['title'] as String,
      subtitle: payload['subtitle'] as String,
      categories: (payload['categories'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => RankingCategory(
              id: item['id'] as String,
              label: item['label'] as String,
            ),
          )
          .toList(growable: false),
      podiumEntries: (payload['podiumEntries'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => RankingPodiumEntry(
              name: item['name'] as String,
              initials: item['initials'] as String,
              positionLabel: item['positionLabel'] as String,
              points: item['points'] as int,
              highlighted: item['highlighted'] as bool,
            ),
          )
          .toList(growable: false),
      entries: (payload['entries'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => RankingListEntry(
              position: item['position'] as int,
              initials: item['initials'] as String,
              name: item['name'] as String,
              levelLabel: item['levelLabel'] as String,
              points: item['points'] as int,
            ),
          )
          .toList(growable: false),
      uiLabels: RankingUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      messages: RankingMessages(
        quickAction: messages['quickAction'] as String,
        categoryAction: messages['categoryAction'] as String,
        entryAction: messages['entryAction'] as String,
      ),
    );
  }
}
