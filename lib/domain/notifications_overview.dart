import 'notification_item.dart';
import 'notifications_messages.dart';
import 'notifications_ui_labels.dart';

class NotificationsOverview {
  const NotificationsOverview({
    required this.title,
    required this.unreadSummary,
    required this.markAllReadLabel,
    required this.items,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final String unreadSummary;
  final String markAllReadLabel;
  final List<NotificationItem> items;
  final NotificationsUiLabels uiLabels;
  final NotificationsMessages messages;
}
