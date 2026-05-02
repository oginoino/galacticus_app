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

  static const _prototype = 'assets/images/prototype';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final overview = provider.overview;
    final compact = MediaQuery.sizeOf(context).width <= 393;

    return Scaffold(
      bottomNavigationBar: BottomNavigationShell(
        currentIndex: provider.selectedTabIndex,
        onSelect: provider.selectTab,
        onCreateTap: () => _showSnack(
          context,
          'Ação rápida disponível na próxima iteração.',
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (provider.isLoading && overview == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppPalette.primary),
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
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 124),
                children: [
                  _Header(overview: overview),
                  const SizedBox(height: 18),
                  _ProgressBar(progress: overview.progress),
                  const SizedBox(height: 16),
                  _BookingCard(overview: overview),
                  const SizedBox(height: 18),
                  _AssistantCard(overview: overview),
                  const SizedBox(height: 18),
                  _HeroCard(overview: overview),
                  const SizedBox(height: 18),
                  const _WorkoutCard(),
                  const SizedBox(height: 22),
                  SectionHeader(
                    title: 'Aulas',
                    actionLabel: 'Ver todas',
                    onActionTap: () => _showSnack(
                      context,
                      'Lista completa de aulas em breve.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: compact ? 170 : 176,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: overview.lessons.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => _LessonCard(
                        lesson: overview.lessons[index],
                        imagePath: _lessonAsset(index),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'Leaderboard',
                    actionLabel: 'Ver ranking',
                    onActionTap: () => _showSnack(
                      context,
                      'Ranking completo em breve.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LeaderboardCard(overview: overview),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'Explorar Hoje',
                    actionLabel: 'Ver todos',
                    onActionTap: () => _showSnack(
                      context,
                      'Agenda completa em breve.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: compact ? 122 : 114,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: overview.exploreEvents.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => _ExploreCard(
                        event: overview.exploreEvents[index],
                        imagePath: _exploreAsset(index),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'Jogue com Amigos',
                    actionLabel: 'Ver agenda',
                    onActionTap: () => _showSnack(
                      context,
                      'Agenda social em breve.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: compact ? 164 : 152,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: overview.matchInvites.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => _InviteCard(
                        invite: overview.matchInvites[index],
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'Calendário',
                    actionLabel: 'Ver tudo',
                    onActionTap: () => _showSnack(
                      context,
                      'Calendário completo em breve.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CalendarCard(overview: overview),
                  const SizedBox(height: 26),
                  const SectionHeader(title: 'Acesso Rápido'),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = (constraints.maxWidth - 12) / 2;
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: overview.quickAccessItems
                            .map(
                              (item) => SizedBox(
                                width: width,
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
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  static String _lessonAsset(int index) {
    const assets = [
      '$_prototype/lesson-saque-slice.jpg',
      '$_prototype/lesson-forehand-topspin.jpg',
      '$_prototype/lesson-backhand-iniciante.jpg',
      '$_prototype/lesson-voleio.jpg',
      '$_prototype/lesson-smash.jpg',
    ];
    return assets[index % assets.length];
  }

  static String _exploreAsset(int index) {
    const assets = [
      '$_prototype/social-tournament.jpg',
      '$_prototype/coach-marcos.jpg',
      '$_prototype/hero-court.jpg',
    ];
    return assets[index % assets.length];
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
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/prototype/paulo.jpg'),
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
        backgroundColor: const Color(0xFF1A2128),
        valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.primary),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

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
            onPressed: () => HomePage._showSnack(
              context,
              'Fluxo de reserva conectado na próxima fase.',
            ),
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

class _AssistantCard extends StatelessWidget {
  const _AssistantCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

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
              'assets/images/prototype/ai-logo.png',
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

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
                    'assets/images/prototype/hero-court.jpg',
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
                    child: CustomPaint(painter: _HeroCourtOverlayPainter()),
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
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                                onPressed: () => HomePage._showSnack(
                                  context,
                                  'Treino guiado conectado na próxima etapa.',
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppPalette.primary,
                                  foregroundColor: Colors.black,
                                  minimumSize: Size.fromHeight(compact ? 46 : 52),
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
                                onPressed: () => HomePage._showSnack(
                                  context,
                                  'Busca de partidas será habilitada na integração.',
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Colors.white.withValues(alpha: 0.13),
                                  side: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.18),
                                  ),
                                  minimumSize: Size.fromHeight(compact ? 46 : 52),
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

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

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

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.lesson,
    required this.imagePath,
  });

  final Lesson lesson;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

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
                      child: Row(
                        children: [
                          if (lesson.isAi)
                            _MiniBadge(
                              label: 'IA',
                              icon: Icons.trending_up_rounded,
                              highlighted: true,
                            ),
                        ],
                      ),
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
                      child: _DurationBadge(label: lesson.duration),
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

class _LeaderboardCard extends StatelessWidget {
  const _LeaderboardCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlowCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: overview.leaderboard
                .map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: entry.isCurrentUser
                          ? const Color(0xFF31401D)
                          : const Color(0xFF171A1E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(
                            '#${entry.position}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: entry.position == 1
                                      ? const Color(0xFFF7C934)
                                      : entry.position == 2
                                          ? const Color(0xFFA7A7A7)
                                          : const Color(0xFFEA8A00),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            _avatarAsset(entry.name),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.name.replaceAll(' Você', ''),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                entry.points,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFBBBBBB),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (entry.isCurrentUser)
                          Text(
                            'Você',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        else
                          Icon(
                            Icons.emoji_events_outlined,
                            color: entry.position == 1
                                ? const Color(0xFFF7C934)
                                : Colors.transparent,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: 12),
        GlowCard(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overview.weeklyHeadline.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFFB0B0B0),
                      letterSpacing: 1.0,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    overview.weeklyTrainings,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF253413),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      overview.weeklyVariation,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppPalette.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const _BarChart(),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _StatMetric(
                      value: overview.totalTime,
                      label: 'Tempo total',
                    ),
                  ),
                  Expanded(
                    child: _StatMetric(
                      value: overview.calories,
                      label: 'Calorias',
                    ),
                  ),
                  Expanded(
                    child: _StatMetric(
                      value: overview.consistency,
                      label: 'Consistência',
                      highlight: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _avatarAsset(String name) {
    if (name.contains('Gabriel')) {
      return 'assets/images/prototype/avatar-gabe.jpg';
    }
    if (name.contains('Leonardo')) {
      return 'assets/images/prototype/avatar-leo.jpg';
    }
    return 'assets/images/prototype/paulo.jpg';
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({
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

class _InviteCard extends StatelessWidget {
  const _InviteCard({required this.invite});

  final MatchInvite invite;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

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
                  backgroundImage: AssetImage(_avatarAsset(invite.hostName)),
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
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              fontSize: compact ? 17 : 18,
                            ),
                      ),
                      Text(
                        invite.sport,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
            _MetaRow(
              icon: Icons.access_time_rounded,
              text: invite.schedule,
            ),
            SizedBox(height: compact ? 8 : 10),
            _MetaRow(
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
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

  String _avatarAsset(String name) {
    if (name.contains('Sofia')) {
      return 'assets/images/prototype/avatar-sofia.jpg';
    }
    if (name.contains('Gabriel')) {
      return 'assets/images/prototype/avatar-gabe.jpg';
    }
    return 'assets/images/prototype/avatar-leo.jpg';
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
    final cells = List<_CalendarCell?>.filled(4, null, growable: true)
      ..addAll(
        overview.calendarDays.map(
          (day) => _CalendarCell(
            label: day.label,
            isSelected: day.isSelected,
            imageAsset: _calendarAsset(day.label, day.isActive),
          ),
        ),
      );

    return GlowCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        children: [
          Row(
            children: [
              _NavCircle(icon: Icons.chevron_left_rounded),
              const Spacer(),
              Text(
                overview.calendarMonthLabel[0].toUpperCase() +
                    overview.calendarMonthLabel.substring(1),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              _NavCircle(icon: Icons.chevron_right_rounded),
            ],
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
                              color: const Color(0xFF696F76),
                            ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final cell = cells[index];
              if (cell == null) {
                return const SizedBox.shrink();
              }

              if (cell.isSelected) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cell.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                );
              }

              if (cell.imageAsset != null) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(cell.imageAsset!),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cell.label,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Text(
                  cell.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF7D838B),
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String? _calendarAsset(String label, bool isActive) {
    if (!isActive) {
      return null;
    }

    return switch (label) {
      '6' => 'assets/images/prototype/cal-workout-1.jpg',
      '10' => 'assets/images/prototype/cal-workout-2.jpg',
      '14' => 'assets/images/prototype/cal-workout-3.jpg',
      '22' => 'assets/images/prototype/cal-workout-2.jpg',
      '28' => 'assets/images/prototype/cal-workout-3.jpg',
      '29' => 'assets/images/prototype/hero-court.jpg',
      '31' => 'assets/images/prototype/cal-workout-1.jpg',
      _ => null,
    };
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({required this.item});

  final QuickAccessItem item;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

    return Container(
      padding: EdgeInsets.all(compact ? 12 : 16),
      constraints: BoxConstraints(
        minHeight: compact ? 176 : 188,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _backgroundAsset(item.icon),
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.26),
                    Colors.black.withValues(alpha: 0.72),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          fontSize: compact ? 16 : 18,
                        ),
                  ),
                  const Spacer(),
                  ..._content(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    switch (item.icon) {
      case 'check':
        return [
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              for (final active in [true, false, true, true, false, true, false])
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active ? AppPalette.primary : const Color(0xFF3A3F45),
                  ),
                  child: active
                      ? const Icon(
                          Icons.check,
                          size: 13,
                          color: Colors.black,
                        )
                      : null,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: ['S', 'T', 'Q', 'Q', 'S', 'S', 'D']
                .map(
                  (label) => Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF848A90),
                            fontSize: 9,
                          ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 8),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFCECECE),
                  fontSize: 13,
                ),
          ),
        ];
      case 'event':
        return [
          Text(
            item.accentLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Torneio de Duplas',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                '14/20',
                style: TextStyle(color: Color(0xFFBEBEBE)),
              ),
            ],
          ),
        ];
      case 'sports':
        return [
          Text(
            'Última partida',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFBEBEBE),
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Você    Rafael',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFBEBEBE),
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '6 × 4',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF223913),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Vitória',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ];
      case 'chart':
        return [
          const _MiniBarChart(),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '85%',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 28,
                    ),
              ),
              Text(
                'consistência',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFFC8C8C8),
                    ),
              ),
            ],
          ),
        ];
      case 'ranking':
        return [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '#12',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sua posição',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFCECECE),
                            ),
                      ),
                      Text(
                        '↑ 3 posições',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPalette.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ];
      case 'shooting':
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'novas fotos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFCECECE),
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...[
                'assets/images/prototype/avatar-gabe.jpg',
                'assets/images/prototype/avatar-sofia.jpg',
                'assets/images/prototype/avatar-leo.jpg',
                'assets/images/prototype/paulo.jpg',
              ].map(
                (asset) => CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'clubs':
        return [
          Text(
            '3 clubes ativos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFCECECE),
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final asset in [
                'assets/images/prototype/paulo.jpg',
                'assets/images/prototype/avatar-sofia.jpg',
                'assets/images/prototype/avatar-leo.jpg',
              ])
                CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(asset),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'calendar':
        return [
          Text(
            'Quadra 03 disponível',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFD1D1D1),
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hoje · 18:00–19:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _SportChip(label: 'Tennis', highlighted: true),
              _SportChip(label: 'Padel'),
            ],
          ),
        ];
      default:
        return [
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFCECECE),
                ),
          ),
        ];
    }
  }

  String _backgroundAsset(String icon) {
    return switch (icon) {
      'check' => 'assets/images/prototype/widget-checkin.jpg',
      'event' => 'assets/images/prototype/widget-eventos.jpg',
      'sports' => 'assets/images/prototype/widget-partidas.jpg',
      'chart' => 'assets/images/prototype/widget-progresso.jpg',
      'ranking' => 'assets/images/prototype/widget-ranking.jpg',
      'shooting' => 'assets/images/prototype/widget-shooting.jpg',
      'clubs' => 'assets/images/prototype/widget-clubes.jpg',
      'calendar' => 'assets/images/prototype/widget-reservar.jpg',
      _ => 'assets/images/prototype/widget-shooting.jpg',
    };
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({
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
          Icon(
            icon,
            size: 12,
            color: Colors.black,
          ),
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

class _DurationBadge extends StatelessWidget {
  const _DurationBadge({required this.label});

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

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width <= 393;

    return Row(
      children: [
        Icon(icon, size: compact ? 14 : 16, color: const Color(0xFF8E949A)),
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

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    const heights = [28.0, 42.0, 20.0, 52.0, 36.0, 58.0, 46.0];
    const labels = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

    return Column(
      children: [
        SizedBox(
          height: 72,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              heights.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    height: heights[index],
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B8D3B),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: labels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF82888F),
                          ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart();

  @override
  Widget build(BuildContext context) {
    const heights = [18.0, 26.0, 14.0, 24.0, 20.0, 28.0, 24.0];

    return SizedBox(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          heights.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: heights[index],
                color: index.isEven
                    ? const Color(0xFF6C8F3D)
                    : const Color(0xFF89B84A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatMetric extends StatelessWidget {
  const _StatMetric({
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: highlight ? AppPalette.primary : Colors.white,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFB1B1B1),
              ),
        ),
      ],
    );
  }
}

class _NavCircle extends StatelessWidget {
  const _NavCircle({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1A1D21),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.04),
        ),
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF9BA1A7)),
    );
  }
}

class _CalendarCell {
  const _CalendarCell({
    required this.label,
    required this.isSelected,
    required this.imageAsset,
  });

  final String label;
  final bool isSelected;
  final String? imageAsset;
}

class _SportChip extends StatelessWidget {
  const _SportChip({
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
        color: highlighted ? const Color(0xFF233913) : const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppPalette.primary : const Color(0xFFCECECE),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HeroCourtOverlayPainter extends CustomPainter {
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
