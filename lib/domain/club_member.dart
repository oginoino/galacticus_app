class ClubMember {
  const ClubMember({
    required this.name,
    required this.roleLabel,
    this.avatarAsset,
    this.initials,
  });

  final String name;
  final String roleLabel;
  final String? avatarAsset;
  final String? initials;
}
