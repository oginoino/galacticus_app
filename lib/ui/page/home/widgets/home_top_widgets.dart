import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSize.avatar,
          height: AppSize.avatar,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.xl),
              width: AppStroke.hairline,
            ),
            image: DecorationImage(
              image: AssetImage(overview.user.avatarAsset),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xl),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${overview.user.levelLabel} · ${overview.user.pointsLabel}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppPalette.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                overview.user.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: AppLetterSpacing.tightXl,
                    ),
              ),
            ],
          ),
        ),
        Container(
          width: AppSize.avatarLg,
          height: AppSize.avatarLg,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppPalette.glassIcon,
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.lg),
              width: AppStroke.hairline,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: AppPalette.white,
                size: AppIconSize.giant,
              ),
              Positioned(
                top: AppSpacing.xxl,
                right: AppSpacing.xxl,
                child: Container(
                  width: AppSize.statusDot,
                  height: AppSize.statusDot,
                  decoration: const BoxDecoration(
                    color: AppPalette.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeProgressBar extends StatelessWidget {
  const HomeProgressBar({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: AppSize.progressHeight,
        backgroundColor: AppPalette.surfaceAlt,
        valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.primary),
      ),
    );
  }
}

class HomeBookingCard extends StatelessWidget {
  const HomeBookingCard({
    super.key,
    required this.overview,
    required this.onPressed,
  });

  final DashboardOverview overview;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return GlowCard(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.xxl : AppSpacing.xxxl,
        vertical: compact ? AppSpacing.xxxl : AppSpacing.huge,
      ),
      child: Row(
        children: [
          Container(
            width: compact ? AppSize.bookingIconCompact : AppSize.bookingIcon,
            height: compact ? AppSize.bookingIconCompact : AppSize.bookingIcon,
            decoration: BoxDecoration(
              color: AppPalette.badgeLocation,
              borderRadius: BorderRadius.circular(AppRadius.xxl),
            ),
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Icon(
                Icons.navigation_outlined,
                color: AppPalette.primary,
                size: compact ? AppIconSize.xl : AppIconSize.xxl,
              ),
            ),
          ),
          SizedBox(width: compact ? AppSpacing.lg : AppSpacing.xl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  overview.locationLabel.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: AppLetterSpacing.wideSm,
                        fontSize: compact ? AppFontSize.bodySm : AppFontSize.body,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${overview.bookingVenue} · ${overview.bookingTime}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: AppLetterSpacing.tightSm,
                        fontSize: compact ? AppFontSize.titleSm : AppFontSize.titleLg,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(width: compact ? AppSpacing.md : AppSpacing.xl),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppPalette.primary,
              foregroundColor: AppPalette.black,
              minimumSize: Size(
                compact ? AppSize.bookingButtonWidthCompact : AppSize.bookingButtonWidth,
                compact ? AppSize.buttonHeightCompact : AppSize.buttonHeight,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: compact ? AppSpacing.xl : AppSpacing.xxxl,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                overview.bookingCta,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: compact ? AppFontSize.bodyLg : AppFontSize.title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAssistantCard extends StatelessWidget {
  const HomeAssistantCard({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return GlowCard(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.xxxl : AppSpacing.huge,
        vertical: compact ? AppSpacing.xxxl : AppSpacing.huge,
      ),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppPalette.assistantStart,
          AppPalette.assistantEnd,
        ],
      ),
      child: Row(
        children: [
          Container(
            width: compact ? AppSize.assistantIconCompact : AppSize.assistantIcon,
            height: compact ? AppSize.assistantIconCompact : AppSize.assistantIcon,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.white.withValues(alpha: AppOpacity.md),
            ),
            padding: EdgeInsets.all(
              compact ? AppSpacing.md : AppSize.assistantInnerPadding,
            ),
            child: Image.asset(
              overview.assistantLogoAsset,
              fit: BoxFit.contain,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  begin: const Offset(
                    AppMotion.assistantLogoPulseMinScale,
                    AppMotion.assistantLogoPulseMinScale,
                  ),
                  end: const Offset(
                    AppMotion.assistantLogoPulseMaxScale,
                    AppMotion.assistantLogoPulseMaxScale,
                  ),
                  duration: AppMotion.assistantLogoPulseDurationMs.ms,
                  curve: Curves.linear,
                )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .rotate(
                  begin: 0,
                  end: 1,
                  duration: AppMotion.assistantLogoRotateDurationMs.ms,
                  curve: Curves.linear,
                ),
          ),
          SizedBox(width: compact ? AppSpacing.xl : AppSpacing.xxl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  overview.assistantLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: AppLetterSpacing.wideMd,
                        fontSize: compact ? AppFontSize.bodySm : AppFontSize.body,
                      ),
                ),
                SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
                Text(
                  overview.assistantTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: AppLetterSpacing.tightXl,
                        fontSize: compact ? AppFontSize.title : AppFontSize.headingSm,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  overview.assistantSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textQuaternary,
                        fontSize: compact ? AppFontSize.body : AppFontSize.bodyLg,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.north_east_rounded,
            color: AppPalette.primary,
            size: compact ? AppIconSize.huge : AppIconSize.giantPlus,
          ),
        ],
      ),
    );
  }
}

class HomeHeroCard extends StatelessWidget {
  const HomeHeroCard({
    super.key,
    required this.overview,
    required this.onPrimaryTap,
    required this.onSecondaryTap,
  });

  final DashboardOverview overview;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return GlowCard(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth = constraints.maxWidth;

          return SizedBox(
            height: compact ? AppSize.heroHeightCompact : AppSize.heroHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                            overview.heroImageAsset,
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppPalette.heroOverlayWarm.withValues(alpha: AppOpacity.accent),
                          AppPalette.heroOverlayDark.withValues(alpha: AppOpacity.quarter),
                          AppPalette.black.withValues(alpha: AppOpacity.overlay),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: compact ? AppHeroLayout.topCompact : AppHeroLayout.top,
                    right: compact ? AppSpacing.xxl : AppSpacing.giant,
                    child: Container(
                              width: compact
                                  ? AppSize.heroIndicatorCompact
                                  : AppSize.heroIndicator,
                              height: compact
                                  ? AppSize.heroIndicatorCompact
                                  : AppSize.heroIndicator,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: const HomeHeroCourtOverlayPainter(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      compact
                          ? AppSize.heroOverlayPaddingCompact
                          : AppSize.heroOverlayPadding,
                      compact
                          ? AppSize.heroOverlayPaddingCompact
                          : AppSize.heroOverlayPadding,
                      compact
                          ? AppSize.heroOverlayPaddingCompact
                          : AppSize.heroOverlayPadding,
                      compact ? AppSpacing.xl : AppSpacing.xxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: contentWidth *
                                (compact
                                    ? AppSize.heroTitleWidthFactorCompact
                                    : AppSize.heroTitleWidthFactor),
                          ),
                          child: Text(
                            overview.heroTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  height: AppSize.heroLineHeight,
                                  letterSpacing: AppLetterSpacing.display,
                                  fontSize: compact
                                      ? AppFontSize.displaySm
                                      : AppFontSize.display,
                                ),
                          ),
                        ),
                        SizedBox(height: compact ? AppSpacing.xs : AppSpacing.md),
                        Text(
                          overview.heroSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppPalette.textGlass,
                                fontWeight: FontWeight.w400,
                                fontSize: compact
                                    ? AppFontSize.bodySm
                                    : AppFontSize.bodyLg,
                              ),
                        ),
                        SizedBox(height: compact ? AppSpacing.md : AppSpacing.xl),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: onPrimaryTap,
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppPalette.primary,
                                  foregroundColor: AppPalette.black,
                                  minimumSize: Size.fromHeight(
                                    compact
                                        ? AppSize.buttonHeightCompact
                                        : AppSize.buttonHeight,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: compact ? AppSpacing.md : AppSpacing.xl,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.button),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    overview.primaryAction,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: compact
                                          ? AppFontSize.body
                                          : AppFontSize.titleSm,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: compact ? AppSpacing.sm : AppSpacing.lg),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: onSecondaryTap,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppPalette.white,
                                  backgroundColor:
                                      AppPalette.white.withValues(alpha: AppOpacity.xxxl),
                                  side: BorderSide(
                                    color: AppPalette.white.withValues(alpha: AppOpacity.strong),
                                  ),
                                  minimumSize: Size.fromHeight(
                                    compact
                                        ? AppSize.buttonHeightCompact
                                        : AppSize.buttonHeight,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: compact ? AppSpacing.sm : AppSpacing.lg,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.button),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    overview.secondaryAction,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: compact
                                          ? AppFontSize.bodySm
                                          : AppFontSize.bodyLg,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeWorkoutCard extends StatelessWidget {
  const HomeWorkoutCard({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.xxl : AppSpacing.xxxl,
        vertical: compact ? AppSpacing.xxl : AppSpacing.xxxl,
      ),
      decoration: BoxDecoration(
        color: AppPalette.primary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: AppPalette.primary.withValues(alpha: AppOpacity.medium),
            blurRadius: AppSpacing.huge,
            offset: const Offset(0, AppSpacing.lg),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: compact ? AppSize.navCenterButton : AppSize.workoutLeading,
            height: compact ? AppSize.navCenterButton : AppSize.workoutLeading,
            decoration: BoxDecoration(
              color: AppPalette.black.withValues(alpha: AppOpacity.xl),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(
              Icons.photo_camera_outlined,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: compact ? AppSpacing.xl : AppSpacing.xxxl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  overview.workoutPromo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPalette.black,
                        fontWeight: FontWeight.w800,
                        letterSpacing: AppLetterSpacing.tightLg,
                        fontSize: compact
                            ? AppFontSize.headingSm
                            : AppFontSize.heading,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  overview.workoutPromo.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.black.withValues(alpha: AppOpacity.text),
                        fontSize: compact ? AppFontSize.body : AppFontSize.bodyLg,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.north_east_rounded,
            color: AppPalette.black.withValues(alpha: AppOpacity.half),
            size: compact ? AppIconSize.xxxl : AppIconSize.giant,
          ),
        ],
      ),
    );
  }
}

class HomeHeroCourtOverlayPainter extends CustomPainter {
  const HomeHeroCourtOverlayPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPalette.white.withValues(alpha: AppOpacity.soft)
      ..strokeWidth = AppStroke.thin;

    canvas.drawLine(
      Offset(size.width * AppHeroLayout.lineX, size.height * AppHeroLayout.lineTop),
      Offset(size.width * AppHeroLayout.lineX, size.height * AppHeroLayout.lineBottom),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height * AppHeroLayout.baselineY),
      Offset(size.width, size.height * AppHeroLayout.baselineY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
