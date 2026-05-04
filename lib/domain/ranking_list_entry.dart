class RankingListEntry {
  const RankingListEntry({
    required this.position,
    required this.initials,
    required this.name,
    required this.levelLabel,
    required this.points,
  });

  final int position;
  final String initials;
  final String name;
  final String levelLabel;
  final int points;
}
