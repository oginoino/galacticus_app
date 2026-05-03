import 'package:flutter/material.dart';

import '../../../../domain/checkin_filter_option.dart';
import '../../../theme/app_theme.dart';

class CheckinTopBar extends StatelessWidget {
  const CheckinTopBar({
    super.key,
    required this.closeSemantics,
    required this.flashSemantics,
    required this.switchCameraSemantics,
    required this.flashEnabled,
    required this.onCloseTap,
    required this.onFlashTap,
    required this.onSwitchCameraTap,
  });

  final String closeSemantics;
  final String flashSemantics;
  final String switchCameraSemantics;
  final bool flashEnabled;
  final VoidCallback onCloseTap;
  final VoidCallback onFlashTap;
  final VoidCallback onSwitchCameraTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: AppResponsiveInsets.overlayTopBar(topInset),
      child: Row(
        children: [
          _CheckinTopAction(
            icon: Icons.close_rounded,
            semanticsLabel: closeSemantics,
            onTap: onCloseTap,
          ),
          const Spacer(),
          _CheckinTopAction(
            icon: flashEnabled ? Icons.flash_on_rounded : Icons.flash_off_rounded,
            semanticsLabel: flashSemantics,
            onTap: onFlashTap,
          ),
          const SizedBox(width: AppSpacing.md),
          _CheckinTopAction(
            icon: Icons.cameraswitch_outlined,
            semanticsLabel: switchCameraSemantics,
            onTap: onSwitchCameraTap,
          ),
        ],
      ),
    );
  }
}

class CheckinCameraPlaceholder extends StatelessWidget {
  const CheckinCameraPlaceholder({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppPalette.textMuted,
              fontSize: AppFontSize.titleSm,
            ),
      ),
    );
  }
}

class CheckinFilterBar extends StatelessWidget {
  const CheckinFilterBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<CheckinFilterOption> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.checkinFilterBarHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final item = items[index];
          final selected = index == selectedIndex;

          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: AppSize.checkinFilterWidth,
                  height: AppSize.checkinFilterHeight,
                  decoration: BoxDecoration(
                    color: AppPalette.surfaceAlt.withValues(alpha: AppOpacity.overlayStrong),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: selected
                          ? AppPalette.primary
                          : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                      width: AppStroke.hairline,
                    ),
                  ),
                  child: Icon(
                    _iconForKey(item.icon),
                    color: selected ? AppPalette.primary : AppPalette.textMuted,
                    size: AppIconSize.xxl,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: selected ? AppPalette.white : AppPalette.textMuted,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: AppFontSize.caption,
                      ),
                ),
                if (selected) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Container(
                    width: AppSpacing.page,
                    height: AppStroke.hairline,
                    color: AppPalette.white,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _iconForKey(String key) {
    switch (key) {
      case 'bar_chart':
        return Icons.bar_chart_rounded;
      case 'location':
        return Icons.location_on_outlined;
      case 'schedule':
        return Icons.schedule_outlined;
      case 'trophy':
        return Icons.emoji_events_outlined;
      case 'score':
        return Icons.sports_score_outlined;
      case 'session':
        return Icons.fitness_center_outlined;
      case 'pulse':
        return Icons.monitor_heart_outlined;
      case 'minimal':
        return Icons.timeline_outlined;
      case 'favorite':
        return Icons.favorite_border_rounded;
      default:
        return Icons.block_rounded;
    }
  }
}

class CheckinCaptureBar extends StatelessWidget {
  const CheckinCaptureBar({
    super.key,
    required this.gallerySemantics,
    required this.captureSemantics,
    required this.onGalleryTap,
    required this.onCaptureTap,
  });

  final String gallerySemantics;
  final String captureSemantics;
  final VoidCallback onGalleryTap;
  final VoidCallback onCaptureTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return Padding(
      padding: AppResponsiveInsets.overlayBottomBar(bottomInset),
      child: Row(
        children: [
          Semantics(
            label: gallerySemantics,
            button: true,
            child: InkWell(
              onTap: onGalleryTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: AppSize.checkinSecondaryAction,
                height: AppSize.checkinSecondaryAction,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.surfaceAlt.withValues(alpha: AppOpacity.overlayStrong),
                  border: Border.all(
                    color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                    width: AppStroke.hairline,
                  ),
                ),
                child: const Icon(
                  Icons.file_upload_outlined,
                  color: AppPalette.textMuted,
                  size: AppIconSize.xxxl,
                ),
              ),
            ),
          ),
          const Spacer(),
          Semantics(
            label: captureSemantics,
            button: true,
            child: InkWell(
              onTap: onCaptureTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: AppSize.checkinCaptureOuter,
                height: AppSize.checkinCaptureOuter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppPalette.white,
                    width: AppStroke.thick,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: AppSize.checkinCaptureInner,
                  height: AppSize.checkinCaptureInner,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPalette.white.withValues(alpha: AppOpacity.quarter),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(
            width: AppSize.checkinSecondaryAction,
            height: AppSize.checkinSecondaryAction,
          ),
        ],
      ),
    );
  }
}

class _CheckinTopAction extends StatelessWidget {
  const _CheckinTopAction({
    required this.icon,
    required this.semanticsLabel,
    required this.onTap,
  });

  final IconData icon;
  final String semanticsLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: SizedBox(
          width: AppSize.checkinTopAction,
          height: AppSize.checkinTopAction,
          child: Icon(
            icon,
            color: AppPalette.white,
            size: AppIconSize.huge,
          ),
        ),
      ),
    );
  }
}
