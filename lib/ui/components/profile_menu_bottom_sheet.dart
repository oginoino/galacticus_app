import 'package:flutter/material.dart';

import '../../domain/profile_menu_item.dart';
import '../theme/app_theme.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final List<ProfileMenuItem> items;
  final ValueChanged<ProfileMenuItem> onItemTap;

  static Future<void> show(
    BuildContext context, {
    required List<ProfileMenuItem> items,
    required ValueChanged<ProfileMenuItem> onItemTap,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppPalette.black.withValues(alpha: AppOpacity.overlay),
      isScrollControlled: false,
      useSafeArea: true,
      builder: (sheetContext) => ProfileMenuBottomSheet(
        items: items,
        onItemTap: (item) {
          Navigator.of(sheetContext).pop();
          onItemTap(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destructiveItems =
        items.where((item) => item.isDestructive).toList(growable: false);
    final regularItems =
        items.where((item) => !item.isDestructive).toList(growable: false);

    return Container(
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.cardXl),
          topRight: Radius.circular(AppRadius.cardXl),
        ),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.lg,
        AppSpacing.page,
        AppSpacing.page,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: AppSize.bottomSheetHandleWidth,
              height: AppSize.bottomSheetHandleHeight,
              decoration: BoxDecoration(
                color: AppPalette.white.withValues(alpha: AppOpacity.sm),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.giant),
          for (final item in regularItems)
            _ProfileMenuTile(
              item: item,
              onTap: () => onItemTap(item),
            ),
          if (destructiveItems.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Divider(
                height: AppStroke.hairline,
                thickness: AppStroke.hairline,
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
              ),
            ),
            for (final item in destructiveItems)
              _ProfileMenuTile(
                item: item,
                onTap: () => onItemTap(item),
              ),
          ],
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.item,
    required this.onTap,
  });

  final ProfileMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        item.isDestructive ? AppPalette.danger : AppPalette.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xl,
        ),
        child: Row(
          children: [
            Icon(
              _iconForKey(item.icon),
              size: AppIconSize.xxl,
              color: color,
            ),
            const SizedBox(width: AppSpacing.giant),
            Expanded(
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFontSize.titleLg,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForKey(String key) {
    switch (key) {
      case 'edit':
        return Icons.edit_outlined;
      case 'achievement':
        return Icons.emoji_events_outlined;
      case 'connections':
        return Icons.link_rounded;
      case 'devices':
        return Icons.settings_input_antenna_rounded;
      case 'settings':
        return Icons.settings_outlined;
      case 'logout':
        return Icons.logout_rounded;
      default:
        return Icons.more_horiz_rounded;
    }
  }
}
