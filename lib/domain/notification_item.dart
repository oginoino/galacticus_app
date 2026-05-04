class NotificationItem {
  const NotificationItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.isUnread,
    this.avatarAsset,
  });

  final String type;
  final String title;
  final String subtitle;
  final String timeLabel;
  final bool isUnread;
  final String? avatarAsset;
}
