import 'package:flutter/material.dart';

import '../../../../domain/notifications_overview.dart';
import '../../../theme/app_theme.dart';
import 'notifications_widgets.dart';

class NotificationsContent extends StatelessWidget {
  const NotificationsContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onMarkAllReadTap,
    required this.onNotificationTap,
  });

  final NotificationsOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onMarkAllReadTap;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: AppInsets.notificationsPage,
      children: [
        NotificationsHeader(
          overview: overview,
          onBackTap: onBackTap,
          onMarkAllReadTap: onMarkAllReadTap,
        ),
        const SizedBox(height: AppSpacing.xl),
        NotificationsList(
          items: overview.items,
          onTap: onNotificationTap,
        ),
      ],
    );
  }
}
