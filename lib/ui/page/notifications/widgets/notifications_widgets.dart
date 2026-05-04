import 'package:flutter/material.dart';

import '../../../../domain/notification_item.dart';
import '../../../theme/app_theme.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<NotificationItem> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.xl),
      itemBuilder: (context, index) => NotificationListItem(
        item: items[index],
        onTap: onTap,
      ),
    );
  }
}

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final NotificationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      child: Padding(
        padding: AppInsets.notificationsItem,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _NotificationLeading(item: item),
                if (item.isUnread)
                  Positioned(
                    top: -AppSpacing.xxs,
                    right: -AppSpacing.xxs,
                    child: Container(
                      width: AppSize.notificationsUnreadDot,
                      height: AppSize.notificationsUnreadDot,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppPalette.white,
                          fontWeight: item.isUnread ? FontWeight.w700 : FontWeight.w500,
                          fontSize: AppFontSize.titleLg,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.subtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodyLg,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xl),
            Text(
              item.timeLabel,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textMuted,
                    fontSize: AppFontSize.body,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationLeading extends StatelessWidget {
  const _NotificationLeading({
    required this.item,
  });

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    if (item.avatarAsset != null) {
      return Container(
        width: AppSize.notificationsAvatar,
        height: AppSize.notificationsAvatar,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(item.avatarAsset!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      width: AppSize.notificationsLeading,
      height: AppSize.notificationsLeading,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.surfaceAlt,
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Icon(
        _iconForType(item.type),
        color: _colorForType(item.type),
        size: AppIconSize.xxl,
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'photo':
        return Icons.camera_alt_outlined;
      case 'community':
        return Icons.groups_2_outlined;
      case 'trophy':
        return Icons.emoji_events_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _colorForType(String type) {
    switch (type) {
      case 'photo':
        return AppPalette.primary;
      case 'trophy':
        return AppPalette.gold;
      case 'community':
        return AppPalette.secondary;
      default:
        return AppPalette.white;
    }
  }
}
