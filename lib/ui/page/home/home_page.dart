import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/community_event.dart';
import '../../../domain/dashboard_overview.dart';
import '../../../domain/lesson.dart';
import '../../../domain/match_invite.dart';
import '../../../domain/quick_access_item.dart';
import '../../../provider/home_provider.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/glow_card.dart';
import '../../components/section_header.dart';
import '../../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final overview = provider.overview;

    return Scaffold(
      bottomNavigationBar: BottomNavigationShell(
        currentIndex: provider.selectedTabIndex,
        onSelect: provider.selectTab,
        onCreateTap: () => _showSnack(context, 'Ação rápida disponível na próxima iteração.'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (provider.isLoading && overview == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppPalette.primary,
                ),
              );
            }

            if (provider.errorMessage != null && overview == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.errorMessage!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: provider.loadDashboard,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (overview == null) {
              return const SizedBox.shrink();
            }

            return RefreshIndicator(
              onRefresh: provider.loadDashboard,
              color: AppPalette.primary,
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                children: [
                  _Header(overview: overview),
                  const SizedBox(height: 20),
                  _ProgressBar(progress: overview.progress),
                  const SizedBox(height: 16),
                  _BookingCard(overview: overview),
                  const SizedBox(height: 16),
                  _AssistantCard(overview: overview),
                  const SizedBox(height: 20),
                  _HeroCard(overview: overview),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Aulas',
                    actionLabel: 'Ver todas',
                    onActionTap: () => _showSnack(context, 'Lista completa de aulas em breve.'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 192,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => _LessonCard(
                        lesson: overview.lessons[index],
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: overview.lessons.length,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Leaderboard',
                    actionLabel: 'Ver ranking',
                    onActionTap: () => _showSnack(context, 'Ranking completo em breve.'),
                  ),
                  const SizedBox(height: 12),
                  _LeaderboardCard(overview: overview),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Explorar Hoje',
                    actionLabel: 'Ver todos',
                    onActionTap: () => _showSnack(context, 'Agenda completa em breve.'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 146,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => _ExploreCard(
                        event: overview.exploreEvents[index],
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: overview.exploreEvents.length,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const SectionHeader(title: 'Jogue com Amigos'),
                  const SizedBox(height: 12),
                  ...overview.matchInvites.map(
                    (invite) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _InviteCard(invite: invite),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const SectionHeader(title: 'Calendário'),
                  const SizedBox(height: 12),
                  _CalendarCard(overview: overview),
                  const SizedBox(height: 28),
                  const SectionHeader(title: 'Acesso Rápido'),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 12) / 2;

                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: overview.quickAccessItems
                            .map(
                              (item) => SizedBox(
                                width: cardWidth,
                                child: _QuickAccessCard(item: item),
                              ),
                            )
                            .toList(growable: false),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppPalette.primaryStrong, AppPalette.secondary],
            ),
            border: Border.all(color: AppPalette.border),
          ),
          alignment: Alignment.center,
          child: Text(
            overview.user.name.characters.first,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
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
                      color: AppPalette.textSecondary,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                overview.user.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppPalette.surface,
            border: Border.all(color: AppPalette.border),
          ),
          child: const Icon(
            Icons.notifications_none,
            color: AppPalette.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: AppPalette.surfaceAlt,
        valueColor: const AlwaysStoppedAnimation<Color>(
          AppPalette.primary,
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppPalette.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.navigation_outlined,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overview.locationLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${overview.bookingVenue} · ${overview.bookingTime}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () => HomePage._showSnack(context, 'Fluxo de reserva conectado na próxima fase.'),
            style: FilledButton.styleFrom(
              backgroundColor: AppPalette.primary,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(overview.bookingCta),
          ),
        ],
      ),
    );
  }
}

class _AssistantCard extends StatelessWidget {
  const _AssistantCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF13250B),
          const Color(0xFF0E1A08).withValues(alpha: 0.94),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.primary.withValues(alpha: 0.08),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overview.assistantLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.4,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  overview.assistantTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  overview.assistantSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.north_east_rounded,
            color: AppPalette.primary,
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      padding: EdgeInsets.zero,
      child: Container(
        height: 244,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3A2313),
              Color(0xFF1A120D),
              Color(0xFF090A0C),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _CourtPainter(),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: AppPalette.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    overview.heroTitle,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          height: 1.05,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    overview.heroSubtitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPalette.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton(
                        onPressed: () => HomePage._showSnack(
                          context,
                          'Treino guiado conectado na próxima etapa.',
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppPalette.primary,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(overview.primaryAction),
                      ),
                      OutlinedButton(
                        onPressed: () => HomePage._showSnack(
                          context,
                          'Busca de partidas será habilitada na integração.',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppPalette.textPrimary,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(overview.secondaryAction),
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

class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 216,
      child: GlowCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Badge(label: lesson.duration),
                const Spacer(),
                if (lesson.isAi) _Badge(label: 'IA', highlighted: true),
              ],
            ),
            const Spacer(),
            Text(
              lesson.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              lesson.coach,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppPalette.textSecondary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              lesson.views,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  const _LeaderboardCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Column(
        children: [
          ...overview.leaderboard.map(
            (entry) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: entry.isCurrentUser
                    ? AppPalette.primary.withValues(alpha: 0.08)
                    : AppPalette.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Text(
                    '#${entry.position}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPalette.primary,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Text(
                    entry.points,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppPalette.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  value: overview.weeklyTrainings,
                  label: overview.weeklyHeadline,
                  accent: overview.weeklyVariation,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricTile(
                  value: overview.totalTime,
                  label: 'Tempo total',
                  accent: overview.calories,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricTile(
                  value: overview.consistency,
                  label: 'Consistência',
                  accent: 'Alta',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({required this.event});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: GlowCard(
        gradient: LinearGradient(
          colors: [
            AppPalette.surfaceAlt,
            const Color(0xFF181E14),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Badge(label: event.tag, highlighted: true),
            const Spacer(),
            Text(
              event.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              event.subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppPalette.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteCard extends StatelessWidget {
  const _InviteCard({required this.invite});

  final MatchInvite invite;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: invite.sport == 'Padel'
                  ? AppPalette.secondary.withValues(alpha: 0.18)
                  : AppPalette.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              invite.sport == 'Padel'
                  ? Icons.sports_tennis_rounded
                  : Icons.emoji_events_outlined,
              color: AppPalette.textPrimary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invite.hostName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  invite.sport,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.primary,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  invite.schedule,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  invite.location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Badge(
                label: invite.availability,
                highlighted: invite.isLastSpot,
              ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: () => HomePage._showSnack(context, 'Entrada na partida será conectada na integração.'),
                child: const Text('Entrar →'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final weekdays = const ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview.calendarMonthLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 14),
          Row(
            children: weekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppPalette.textSecondary,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: overview.calendarDays.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final day = overview.calendarDays[index];
              return Container(
                decoration: BoxDecoration(
                  color: day.isSelected
                      ? AppPalette.primary
                      : day.isActive
                          ? AppPalette.primary.withValues(alpha: 0.12)
                          : AppPalette.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  day.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: day.isSelected ? Colors.black : AppPalette.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({required this.item});

  final QuickAccessItem item;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppPalette.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _iconFor(item.icon),
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            item.accentLabel,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String icon) {
    return switch (icon) {
      'check' => Icons.check_circle_outline,
      'event' => Icons.event_available_outlined,
      'sports' => Icons.sports_score_outlined,
      'chart' => Icons.insights_outlined,
      'ranking' => Icons.emoji_events_outlined,
      'calendar' => Icons.calendar_month_outlined,
      _ => Icons.auto_awesome_outlined,
    };
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.value,
    required this.label,
    required this.accent,
  });

  final String value;
  final String label;
  final String accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPalette.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            accent,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlighted
            ? AppPalette.primary.withValues(alpha: 0.16)
            : AppPalette.surface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: highlighted ? AppPalette.primary : AppPalette.textSecondary,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _CourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final glowPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0x33B7F36B),
          Color(0x00000000),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.86, size.height * 0.18),
          radius: size.shortestSide * 0.28,
        ),
      );

    canvas.drawRect(Offset.zero & size, glowPaint);

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 2;

    final outer = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, 24, size.width - 40, size.height - 56),
      const Radius.circular(18),
    );
    canvas.drawRRect(outer, linePaint);

    canvas.drawLine(
      Offset(size.width / 2, 24),
      Offset(size.width / 2, size.height - 32),
      linePaint,
    );

    canvas.drawLine(
      Offset(20, size.height / 2),
      Offset(size.width - 20, size.height / 2),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
