class FeedStory {
  const FeedStory({
    required this.label,
    required this.avatarAsset,
    required this.initials,
    required this.ringColorHex,
    required this.hasAddBadge,
  });

  final String label;
  final String? avatarAsset;
  final String? initials;
  final String ringColorHex;
  final bool hasAddBadge;
}
