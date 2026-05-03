class DiscoverClub {
  const DiscoverClub({
    required this.title,
    required this.tagsLabel,
    required this.subtitle,
    required this.membersLabel,
    required this.joinLabel,
    required this.imageAsset,
    required this.memberAvatarAssets,
  });

  final String title;
  final String tagsLabel;
  final String subtitle;
  final String membersLabel;
  final String joinLabel;
  final String imageAsset;
  final List<String> memberAvatarAssets;
}
