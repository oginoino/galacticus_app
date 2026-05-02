import 'package:flutter/material.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../components/section_header.dart';
import 'home_assets.dart';
import 'home_cards_widgets.dart';
import 'home_dashboard_widgets.dart';
import 'home_quick_access_widgets.dart';
import 'home_top_widgets.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.overview,
    required this.onMessage,
  });

  final DashboardOverview overview;
  final ValueChanged<String> onMessage;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(16, topInset + 10, 16, 124),
      children: [
        HomeHeader(overview: overview),
        const SizedBox(height: 18),
        HomeProgressBar(progress: overview.progress),
        const SizedBox(height: 16),
        HomeBookingCard(
          overview: overview,
          onPressed: () => onMessage(
            'Fluxo de reserva conectado na próxima fase.',
          ),
        ),
        const SizedBox(height: 18),
        HomeAssistantCard(overview: overview),
        const SizedBox(height: 18),
        HomeHeroCard(
          overview: overview,
          onPrimaryTap: () => onMessage(
            'Treino guiado conectado na próxima etapa.',
          ),
          onSecondaryTap: () => onMessage(
            'Busca de partidas será habilitada na integração.',
          ),
        ),
        const SizedBox(height: 18),
        const HomeWorkoutCard(),
        const SizedBox(height: 22),
        SectionHeader(
          title: 'Aulas',
          actionLabel: 'Ver todas',
          onActionTap: () => onMessage(
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
            itemBuilder: (context, index) => HomeLessonCard(
              lesson: overview.lessons[index],
              imagePath: HomePrototypeAssets.lessonByIndex(index),
            ),
          ),
        ),
        const SizedBox(height: 26),
        SectionHeader(
          title: 'Leaderboard',
          actionLabel: 'Ver ranking',
          onActionTap: () => onMessage(
            'Ranking completo em breve.',
          ),
        ),
        const SizedBox(height: 12),
        HomeLeaderboardCard(overview: overview),
        const SizedBox(height: 26),
        SectionHeader(
          title: 'Explorar Hoje',
          actionLabel: 'Ver todos',
          onActionTap: () => onMessage(
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
            itemBuilder: (context, index) => HomeExploreCard(
              event: overview.exploreEvents[index],
              imagePath: HomePrototypeAssets.exploreByIndex(index),
            ),
          ),
        ),
        const SizedBox(height: 26),
        SectionHeader(
          title: 'Jogue com Amigos',
          actionLabel: 'Ver agenda',
          onActionTap: () => onMessage(
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
            itemBuilder: (context, index) => HomeInviteCard(
              invite: overview.matchInvites[index],
            ),
          ),
        ),
        const SizedBox(height: 26),
        SectionHeader(
          title: 'Calendário',
          actionLabel: 'Ver tudo',
          onActionTap: () => onMessage(
            'Calendário completo em breve.',
          ),
        ),
        const SizedBox(height: 12),
        HomeCalendarCard(overview: overview),
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
                      child: HomeQuickAccessCard(item: item),
                    ),
                  )
                  .toList(growable: false),
            );
          },
        ),
      ],
    );
  }
}
