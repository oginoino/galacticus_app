import 'package:flutter/material.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../components/section_header.dart';
import '../../../theme/app_theme.dart';
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
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screen,
        topInset + AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.bottomContent,
      ),
      children: [
        HomeHeader(overview: overview),
        const SizedBox(height: AppSpacing.huge),
        HomeProgressBar(progress: overview.progress),
        const SizedBox(height: AppSpacing.xxxl),
        HomeBookingCard(
          overview: overview,
          onPressed: () => onMessage(
            'Fluxo de reserva conectado na próxima fase.',
          ),
        ),
        const SizedBox(height: AppSpacing.huge),
        HomeAssistantCard(overview: overview),
        const SizedBox(height: AppSpacing.huge),
        HomeHeroCard(
          overview: overview,
          onPrimaryTap: () => onMessage(
            'Treino guiado conectado na próxima etapa.',
          ),
          onSecondaryTap: () => onMessage(
            'Busca de partidas será habilitada na integração.',
          ),
        ),
        const SizedBox(height: AppSpacing.huge),
        const HomeWorkoutCard(),
        const SizedBox(height: AppSpacing.section),
        SectionHeader(
          title: 'Aulas',
          actionLabel: 'Ver todas',
          onActionTap: () => onMessage(
            'Lista completa de aulas em breve.',
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: compact ? 170 : 176,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: overview.lessons.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
            itemBuilder: (context, index) => HomeLessonCard(
              lesson: overview.lessons[index],
              imagePath: HomePrototypeAssets.lessonByIndex(index),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: 'Leaderboard',
          actionLabel: 'Ver ranking',
          onActionTap: () => onMessage(
            'Ranking completo em breve.',
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        HomeLeaderboardCard(overview: overview),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: 'Explorar Hoje',
          actionLabel: 'Ver todos',
          onActionTap: () => onMessage(
            'Agenda completa em breve.',
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: compact ? 122 : 114,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: overview.exploreEvents.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
            itemBuilder: (context, index) => HomeExploreCard(
              event: overview.exploreEvents[index],
              imagePath: HomePrototypeAssets.exploreByIndex(index),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: 'Jogue com Amigos',
          actionLabel: 'Ver agenda',
          onActionTap: () => onMessage(
            'Agenda social em breve.',
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: compact ? 164 : 152,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: overview.matchInvites.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
            itemBuilder: (context, index) => HomeInviteCard(
              invite: overview.matchInvites[index],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionLg),
        SectionHeader(
          title: 'Calendário',
          actionLabel: 'Ver tudo',
          onActionTap: () => onMessage(
            'Calendário completo em breve.',
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        HomeCalendarCard(overview: overview),
        const SizedBox(height: AppSpacing.sectionLg),
        const SectionHeader(title: 'Acesso Rápido'),
        const SizedBox(height: AppSpacing.xl),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = (constraints.maxWidth - AppSpacing.xl) / 2;
            return Wrap(
              spacing: AppSpacing.xl,
              runSpacing: AppSpacing.xl,
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
