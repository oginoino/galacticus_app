class MatchPlayer {
  const MatchPlayer({
    required this.name,
    required this.initials,
    this.avatarAsset,
  });

  final String name;
  final String initials;
  final String? avatarAsset;
}
