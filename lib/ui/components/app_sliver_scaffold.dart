import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../route/routes/routes.dart';
import '../theme/app_theme.dart';

class AppCircleIconButton extends StatelessWidget {
  const AppCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = AppSize.headerActionButton,
    this.iconSize = AppIconSize.huge,
    this.iconColor = AppPalette.white,
    this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? AppPalette.surfaceAlt,
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}

class AppSliverAppBar extends StatelessWidget {
  const AppSliverAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.showBackButton = true,
    this.onBackTap,
    this.fallbackRoute = Routes.home,
    this.floating = true,
    this.pinned = false,
    this.snap = true,
  });

  static const double toolbarHeight = 64.0;
  static const double subtitleHeight = 32.0;

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final String fallbackRoute;
  final bool floating;
  final bool pinned;
  final bool snap;

  @override
  Widget build(BuildContext context) {
    final hasSubtitle = subtitle != null && subtitle!.isNotEmpty;

    return SliverAppBar(
      pinned: pinned,
      floating: floating,
      snap: floating && snap,
      backgroundColor: AppPalette.background,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      titleSpacing: 0,
      toolbarHeight: toolbarHeight,
      leadingWidth: AppSpacing.page + AppSize.headerActionButton + AppSpacing.lg,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.page,
                right: AppSpacing.lg,
              ),
              child: Center(
                child: AppCircleIconButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: onBackTap ?? () => _defaultBack(context),
                ),
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.heading,
              letterSpacing: AppLetterSpacing.tightSm,
            ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.page),
          child: Center(
            child: trailing ?? const SizedBox(width: AppSize.headerActionButton),
          ),
        ),
      ],
      bottom: hasSubtitle
          ? PreferredSize(
              preferredSize: const Size.fromHeight(subtitleHeight),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  0,
                  AppSpacing.page,
                  AppSpacing.lg,
                ),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppPalette.textMuted,
                        fontSize: AppFontSize.bodyLg,
                      ),
                ),
              ),
            )
          : null,
    );
  }

  void _defaultBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(fallbackRoute);
  }
}

class AppSliverScaffold extends StatelessWidget {
  const AppSliverScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.showBackButton = true,
    this.onBackTap,
    this.fallbackRoute = Routes.home,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.slivers = const <Widget>[],
    this.floatingHeader = true,
    this.pinnedHeader = false,
    this.snapHeader = true,
    this.onRefresh,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final String fallbackRoute;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final List<Widget> slivers;
  final bool floatingHeader;
  final bool pinnedHeader;
  final bool snapHeader;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final scrollView = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        AppSliverAppBar(
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          showBackButton: showBackButton,
          onBackTap: onBackTap,
          fallbackRoute: fallbackRoute,
          floating: floatingHeader,
          pinned: pinnedHeader,
          snap: snapHeader,
        ),
        ...slivers,
        SliverToBoxAdapter(
          child: SizedBox(
            height: bottomNavigationBar != null
                ? AppSpacing.bottomContent
                : AppSpacing.section,
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: backgroundColor ?? AppPalette.background,
      extendBody: bottomNavigationBar != null,
      bottomNavigationBar: bottomNavigationBar,
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              color: AppPalette.primary,
              child: scrollView,
            )
          : scrollView,
    );
  }
}
