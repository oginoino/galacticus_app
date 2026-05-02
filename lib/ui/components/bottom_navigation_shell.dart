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
        padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset > 0 ? 2 : 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: IgnorePointer(
                child: Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppPalette.primaryStrong.withValues(alpha: 0.58),
                        AppPalette.primaryStrong.withValues(alpha: 0.18),
                        AppPalette.primaryStrong.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.42, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                child: Container(
                  height: 82,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0x6B2A2E34),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.10),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.26),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
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
                      const SizedBox(width: 72),
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
              borderRadius: BorderRadius.circular(999),
              onTap: onCreateTap,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppPalette.primaryStrong,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 28,
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
        ? Colors.white
        : Colors.white.withValues(alpha: 0.26);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: foreground,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
