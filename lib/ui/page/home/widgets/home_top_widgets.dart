import 'package:flutter/material.dart';

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
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
            image: const DecorationImage(
              image: AssetImage('${HomePrototypeAssets.basePath}/paulo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${overview.user.levelLabel} · ${overview.user.pointsLabel}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFBFC3C8),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                overview.user.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
              ),
            ],
          ),
        ),
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0D1218),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 28,
              ),
              Positioned(
                top: 13,
                right: 14,
                child: Container(
                  width: 10,
                  height: 10,
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
      borderRadius: BorderRadius.circular(999),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: const Color(0xFF1A2128),
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
        horizontal: compact ? 14 : 16,
        vertical: compact ? 16 : 18,
      ),
      child: Row(
        children: [
          Container(
            width: compact ? 40 : 42,
            height: compact ? 40 : 42,
            decoration: BoxDecoration(
              color: const Color(0xFF182715),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.navigation_outlined,
              color: AppPalette.primary,
              size: compact ? 20 : 22,
            ),
          ),
          SizedBox(width: compact ? 10 : 12),
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
                        letterSpacing: 1.0,
                        fontSize: compact ? 12 : 13,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${overview.bookingVenue} · ${overview.bookingTime}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                        fontSize: compact ? 15 : 17,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(width: compact ? 8 : 12),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppPalette.primary,
              foregroundColor: Colors.black,
              minimumSize: Size(compact ? 92 : 104, compact ? 46 : 52),
              padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                overview.bookingCta,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: compact ? 14 : 16,
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
        horizontal: compact ? 16 : 18,
        vertical: compact ? 16 : 18,
      ),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF022900),
          Color(0xFF113500),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: compact ? 46 : 50,
            height: compact ? 46 : 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.06),
            ),
            padding: EdgeInsets.all(compact ? 8 : 9),
            child: Image.asset(
              '${HomePrototypeAssets.basePath}/ai-logo.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: compact ? 12 : 14),
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
                        letterSpacing: 1.6,
                        fontSize: compact ? 12 : 13,
                      ),
                ),
                SizedBox(height: compact ? 6 : 8),
                Text(
                  overview.assistantTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.8,
                        fontSize: compact ? 16 : 18,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  overview.assistantSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFB8C0B4),
                        fontSize: compact ? 13 : 14,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.north_east_rounded,
            color: AppPalette.primary,
            size: compact ? 26 : 30,
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
            height: compact ? 204 : 224,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    '${HomePrototypeAssets.basePath}/hero-court.jpg',
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF7A3400).withValues(alpha: 0.38),
                          const Color(0xFF101010).withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.72),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: compact ? 16 : 22,
                    right: compact ? 14 : 20,
                    child: Container(
                      width: compact ? 14 : 18,
                      height: compact ? 14 : 18,
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
                      compact ? 12 : 16,
                      compact ? 12 : 16,
                      compact ? 12 : 16,
                      compact ? 12 : 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: contentWidth * (compact ? 0.58 : 0.62),
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
                                  height: 0.95,
                                  letterSpacing: -1.2,
                                  fontSize: compact ? 30 : 38,
                                ),
                          ),
                        ),
                        SizedBox(height: compact ? 4 : 8),
                        Text(
                          overview.heroSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: const Color(0xFFC8C8C8),
                                fontWeight: FontWeight.w400,
                                fontSize: compact ? 12 : 14,
                              ),
                        ),
                        SizedBox(height: compact ? 8 : 12),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: onPrimaryTap,
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppPalette.primary,
                                  foregroundColor: Colors.black,
                                  minimumSize: Size.fromHeight(
                                    compact ? 46 : 52,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: compact ? 8 : 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    overview.primaryAction,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: compact ? 13 : 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: compact ? 6 : 10),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: onSecondaryTap,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Colors.white.withValues(alpha: 0.13),
                                  side: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.18),
                                  ),
                                  minimumSize: Size.fromHeight(
                                    compact ? 46 : 52,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: compact ? 6 : 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    overview.secondaryAction,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: compact ? 12 : 14,
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
  const HomeWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 14 : 16,
        vertical: compact ? 14 : 16,
      ),
      decoration: BoxDecoration(
        color: AppPalette.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppPalette.primary.withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: compact ? 44 : 48,
            height: compact ? 44 : 48,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.photo_camera_outlined,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: compact ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHECK-IN WORKOUT',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                        fontSize: compact ? 18 : 20,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Registre seu treino agora',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withValues(alpha: 0.66),
                        fontSize: compact ? 13 : 14,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.north_east_rounded,
            color: Colors.black.withValues(alpha: 0.5),
            size: compact ? 24 : 28,
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
      ..color = Colors.white.withValues(alpha: 0.14)
      ..strokeWidth = 1.2;

    canvas.drawLine(
      Offset(size.width * 0.48, size.height * 0.16),
      Offset(size.width * 0.48, size.height * 0.86),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.62),
      Offset(size.width, size.height * 0.62),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
