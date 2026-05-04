class RankingPodiumEntry {
  const RankingPodiumEntry({
    required this.name,
    required this.initials,
    required this.positionLabel,
    required this.points,
    required this.highlighted,
  });

  final String name;
  final String initials;
  final String positionLabel;
  final int points;
  final bool highlighted;
}
