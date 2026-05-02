import 'package:flutter/material.dart';

import '../../../../domain/community_event.dart';
import '../../../../domain/lesson.dart';
import '../../../../domain/match_invite.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';

class HomeLessonCard extends StatelessWidget {
  const HomeLessonCard({
    super.key,
    required this.lesson,
    required this.imagePath,
  });

  final Lesson lesson;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      width: compact ? 162 : 176,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111316),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(imagePath, fit: BoxFit.cover),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.black.withValues(alpha: 0.08),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: lesson.isAi
                          ? const HomeMiniBadge(
                              label: 'IA',
                              icon: Icons.trending_up_rounded,
                              highlighted: true,
                            )
                          : const SizedBox.shrink(),
                    ),
                    Center(
                      child: Container(
                        width: compact ? 46 : 52,
                        height: compact ? 46 : 52,
                        decoration: const BoxDecoration(
                          color: AppPalette.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.black,
                          size: compact ? 30 : 34,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: HomeDurationBadge(label: lesson.duration),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                          fontSize: compact ? 14 : 16,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lesson.coach,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: const Color(0xFFAAAAAA),
                                fontSize: compact ? 12 : 13,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lesson.views,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFAAAAAA),
                              fontSize: compact ? 11 : 12,
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
  }
}

class HomeExploreCard extends StatelessWidget {
  const HomeExploreCard({
    super.key,
    required this.event,
    required this.imagePath,
  });

  final CommunityEvent event;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFD5D5D5),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeInviteCard extends StatelessWidget {
  const HomeInviteCard({
    super.key,
    required this.invite,
  });

  final MatchInvite invite;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      width: compact ? 208 : 226,
      child: GlowCard(
        padding: EdgeInsets.fromLTRB(
          compact ? 12 : 14,
          compact ? 12 : 14,
          compact ? 12 : 14,
          compact ? 10 : 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: compact ? 20 : 24,
                  backgroundImage: AssetImage(
                    HomePrototypeAssets.inviteAvatar(invite.hostName),
                  ),
                ),
                SizedBox(width: compact ? 10 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        invite.hostName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              fontSize: compact ? 17 : 18,
                            ),
                      ),
                      Text(
                        invite.sport,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: const Color(0xFFBDBDBD),
                              fontSize: compact ? 12 : 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: compact ? 12 : 16),
            HomeMetaRow(
              icon: Icons.access_time_rounded,
              text: invite.schedule,
            ),
            SizedBox(height: compact ? 8 : 10),
            HomeMetaRow(
              icon: Icons.location_on_outlined,
              text: invite.location,
            ),
            SizedBox(height: compact ? 10 : 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: invite.isLastSpot
                          ? const Color(0xFF5F4410)
                          : const Color(0xFF223913),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      invite.availability,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                            color: invite.isLastSpot
                                ? const Color(0xFFF8C55C)
                                : AppPalette.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: compact ? 12 : 13,
                          ),
                    ),
                  ),
                ),
                SizedBox(width: compact ? 8 : 10),
                Text(
                  'Entrar →',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: compact ? 12 : 13,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMiniBadge extends StatelessWidget {
  const HomeMiniBadge({
    super.key,
    required this.label,
    required this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.primary : const Color(0xFF171717),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.black),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDurationBadge extends StatelessWidget {
  const HomeDurationBadge({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class HomeMetaRow extends StatelessWidget {
  const HomeMetaRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return Row(
      children: [
        Icon(
          icon,
          size: compact ? 14 : 16,
          color: const Color(0xFF8E949A),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFB8B8B8),
                  fontSize: compact ? 12 : 14,
                ),
          ),
        ),
      ],
    );
  }
}
