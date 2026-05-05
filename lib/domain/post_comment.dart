class PostComment {
  const PostComment({
    required this.author,
    required this.timeLabel,
    required this.message,
    required this.likesLabel,
    this.avatarAsset,
    this.initials,
  });

  final String author;
  final String timeLabel;
  final String message;
  final String likesLabel;
  final String? avatarAsset;
  final String? initials;
}
