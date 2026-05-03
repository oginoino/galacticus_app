class LeaderboardEntry {
  const LeaderboardEntry({
    required this.position,
    required this.name,
    required this.points,
    required this.isCurrentUser,
    required this.avatarAsset,
  });

  final int position;
  final String name;
  final String points;
  final bool isCurrentUser;
  final String avatarAsset;
}
