import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BottomNavigationShell extends StatelessWidget {
  const BottomNavigationShell({
    super.key,
    required this.currentIndex,
    required this.onSelect,
    this.onCreateTap,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback? onCreateTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppOpacity.none,
          AppSpacing.screen,
          bottomInset > 0 ? AppSize.navBottomPaddingSafe : AppSize.navBottomPadding,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: IgnorePointer(
                child: Container(
                  width: AppSize.navGlow,
                  height: AppSize.navGlow,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppPalette.primaryStrong.withValues(alpha: AppOpacity.heavy),
                        AppPalette.primaryStrong.withValues(alpha: AppOpacity.strong),
                        AppPalette.primaryStrong.withValues(alpha: AppOpacity.none),
                      ],
                      stops: const [0.0, 0.42, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: AppBlur.navGlass,
                  sigmaY: AppBlur.navGlass,
                ),
                child: Container(
                  height: AppSize.navBarHeight,
                  padding: AppInsets.navBar,
                  decoration: BoxDecoration(
                    color: AppPalette.glassDark,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(
                      color: AppPalette.white.withValues(alpha: AppOpacity.xl),
                      width: AppStroke.hairline,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppPalette.black.withValues(alpha: AppOpacity.stronger),
                        blurRadius: AppShadow.navBlur,
                        offset: const Offset(0, AppShadow.navOffsetY),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _NavItem(
                          icon: Icons.home_outlined,
                          label: 'Início',
                          selected: currentIndex == 0,
                          onTap: () => onSelect(0),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: Icons.rss_feed_outlined,
                          label: 'Feed',
                          selected: currentIndex == 1,
                          onTap: () => onSelect(1),
                        ),
                      ),
                      const SizedBox(width: AppSize.navCenterGap),
                      Expanded(
                        child: _NavItem(
                          icon: Icons.shield_outlined,
                          label: 'Clubes',
                          selected: currentIndex == 2,
                          onTap: () => onSelect(2),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: Icons.person_outline,
                          label: 'Perfil',
                          selected: currentIndex == 3,
                          onTap: () => onSelect(3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              onTap: onCreateTap,
              child: Container(
                width: AppSize.navCenterButton,
                height: AppSize.navCenterButton,
                decoration: const BoxDecoration(
                  color: AppPalette.primaryStrong,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppPalette.black,
                  size: AppIconSize.giant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? AppPalette.white
        : AppPalette.white.withValues(alpha: AppOpacity.stronger);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xxxl),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.xxs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: foreground,
              size: AppIconSize.xxxl,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: AppFontSize.label,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
