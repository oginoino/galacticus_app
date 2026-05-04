import 'package:flutter/material.dart';

import '../../../../domain/notifications_overview.dart';
import '../../../theme/app_theme.dart';
import 'notifications_widgets.dart';

class NotificationsContent extends StatelessWidget {
  const NotificationsContent({
    super.key,
    required this.overview,
    required this.onNotificationTap,
  });

  final NotificationsOverview overview;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.notificationsPage,
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          NotificationsList(
            items: overview.items,
            onTap: onNotificationTap,
          ),
        ],
      ),
    );
  }
}
