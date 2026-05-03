import '../domain/notification_item.dart';
import '../domain/notifications_messages.dart';
import '../domain/notifications_overview.dart';
import '../domain/notifications_ui_labels.dart';

class NotificationsDto {
  NotificationsDto({
    required this.payload,
  });

  factory NotificationsDto.fromJson(Map<String, dynamic> json) {
    return NotificationsDto(payload: json);
  }

  final Map<String, dynamic> payload;

  NotificationsOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return NotificationsOverview(
      title: payload['title'] as String,
      unreadSummary: payload['unreadSummary'] as String,
      markAllReadLabel: payload['markAllReadLabel'] as String,
      items: (payload['items'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => NotificationItem(
              type: item['type'] as String,
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              timeLabel: item['timeLabel'] as String,
              isUnread: item['isUnread'] as bool,
              avatarAsset: item['avatarAsset'] as String?,
            ),
          )
          .toList(growable: false),
      uiLabels: NotificationsUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      messages: NotificationsMessages(
        quickAction: messages['quickAction'] as String,
        markAllReadAction: messages['markAllReadAction'] as String,
        notificationTapAction: messages['notificationTapAction'] as String,
      ),
    );
  }
}
