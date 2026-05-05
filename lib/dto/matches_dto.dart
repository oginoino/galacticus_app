import '../domain/match_filter_chip.dart';
import '../domain/match_messages.dart';
import '../domain/match_overview.dart';
import '../domain/match_player.dart';
import '../domain/match_record.dart';

class MatchesDto {
  MatchesDto({required this.payload});

  factory MatchesDto.fromJson(Map<String, dynamic> json) {
    return MatchesDto(payload: json);
  }

  final Map<String, dynamic> payload;

  MatchOverview toDomain() {
    final messages = payload['messages'] as Map<String, dynamic>;

    return MatchOverview(
      title: payload['title'] as String,
      subtitle: payload['subtitle'] as String,
      filterChipsTitle: payload['filterChipsTitle'] as String,
      emptyLabel: payload['emptyLabel'] as String,
      filters: (payload['filters'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => MatchFilterChip(
              label: item['label'] as String,
              value: item['value'] as String,
              isSelected: item['isSelected'] as bool? ?? false,
            ),
          )
          .toList(growable: false),
      items: (payload['items'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(_parseRecord)
          .toList(growable: false),
      messages: MatchMessages(
        filterAction: messages['filterAction'] as String,
        openDetailAction: messages['openDetailAction'] as String,
        loadErrorMessage: messages['loadErrorMessage'] as String,
      ),
    );
  }

  MatchRecord _parseRecord(Map<String, dynamic> item) {
    return MatchRecord(
      id: item['id'] as String,
      sportLabel: item['sportLabel'] as String,
      sportKey: item['sportKey'] as String,
      dateLabel: item['dateLabel'] as String,
      relativeTime: item['relativeTime'] as String,
      statusLabel: item['statusLabel'] as String,
      statusHighlighted: item['statusHighlighted'] as bool? ?? false,
      players: (item['players'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (player) => MatchPlayer(
              name: player['name'] as String,
              initials: player['initials'] as String,
              avatarAsset: player['avatarAsset'] as String?,
            ),
          )
          .toList(growable: false),
      scoreLabel: item['scoreLabel'] as String,
      locationLabel: item['locationLabel'] as String?,
      durationLabel: item['durationLabel'] as String?,
      resultBadge: item['resultBadge'] as String?,
    );
  }
}
