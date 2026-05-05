class TrainingComment {
  const TrainingComment({
    required this.author,
    required this.timeLabel,
    required this.message,
    this.avatarAsset,
    this.initials,
  });

  final String author;
  final String timeLabel;
  final String message;
  final String? avatarAsset;
  final String? initials;
}
