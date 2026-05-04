import 'ranking_category.dart';
import 'ranking_list_entry.dart';
import 'ranking_messages.dart';
import 'ranking_podium_entry.dart';
import 'ranking_ui_labels.dart';

class RankingOverview {
  const RankingOverview({
    required this.title,
    required this.subtitle,
    required this.categories,
    required this.podiumEntries,
    required this.entries,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final String subtitle;
  final List<RankingCategory> categories;
  final List<RankingPodiumEntry> podiumEntries;
  final List<RankingListEntry> entries;
  final RankingUiLabels uiLabels;
  final RankingMessages messages;
}
