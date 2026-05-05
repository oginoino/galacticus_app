import 'match_filter_chip.dart';
import 'match_messages.dart';
import 'match_record.dart';

class MatchOverview {
  const MatchOverview({
    required this.title,
    required this.subtitle,
    required this.filterChipsTitle,
    required this.filters,
    required this.items,
    required this.emptyLabel,
    required this.messages,
  });

  final String title;
  final String subtitle;
  final String filterChipsTitle;
  final List<MatchFilterChip> filters;
  final List<MatchRecord> items;
  final String emptyLabel;
  final MatchMessages messages;
}
