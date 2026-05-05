import 'match_player.dart';

class MatchRecord {
  const MatchRecord({
    required this.id,
    required this.sportLabel,
    required this.sportKey,
    required this.dateLabel,
    required this.relativeTime,
    required this.statusLabel,
    required this.statusHighlighted,
    required this.players,
    required this.scoreLabel,
    this.locationLabel,
    this.durationLabel,
    this.resultBadge,
  });

  final String id;
  final String sportLabel;
  final String sportKey;
  final String dateLabel;
  final String relativeTime;
  final String statusLabel;
  final bool statusHighlighted;
  final List<MatchPlayer> players;
  final String scoreLabel;
  final String? locationLabel;
  final String? durationLabel;
  final String? resultBadge;
}
