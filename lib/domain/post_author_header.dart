class PostAuthorHeader {
  const PostAuthorHeader({
    required this.authorHandle,
    required this.contextLabel,
    this.avatarAsset,
    this.initials,
  });

  final String authorHandle;
  final String contextLabel;
  final String? avatarAsset;
  final String? initials;
}
