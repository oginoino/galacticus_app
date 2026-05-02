class LeaderboardEntry {
  const LeaderboardEntry({
    required this.position,
    required this.name,
    required this.points,
    required this.isCurrentUser,
  });

  final int position;
  final String name;
  final String points;
  final bool isCurrentUser;
}
