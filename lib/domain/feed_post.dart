class FeedPost {
  const FeedPost({
    required this.authorHandle,
    required this.clubLabel,
    required this.timeAgoLabel,
    required this.avatarAsset,
    required this.initials,
    required this.imageAsset,
    required this.sportLabel,
    required this.likesCountLabel,
    required this.commentsCountLabel,
    required this.viewCommentsLabel,
  });

  final String authorHandle;
  final String clubLabel;
  final String timeAgoLabel;
  final String? avatarAsset;
  final String? initials;
  final String imageAsset;
  final String sportLabel;
  final String likesCountLabel;
  final String commentsCountLabel;
  final String viewCommentsLabel;
}
