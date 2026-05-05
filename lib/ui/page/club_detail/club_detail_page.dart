import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../route/routes/routes.dart';
import '../../theme/app_theme.dart';
import '../granular/widgets/granular_widgets.dart';

class ClubDetailPage extends StatelessWidget {
  const ClubDetailPage({
    super.key,
    required this.slug,
  });

  final String slug;

  @override
  Widget build(BuildContext context) {
    final club = _clubFor(slug);

    return HubPageScaffold(
      title: club.name,
      subtitle: '${club.members} membros · ${club.privacy}',
      trailing: const HubMetaChip(label: '+34', highlighted: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: club.tags.map((tag) => HubMetaChip(label: tag)).toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.section),
          HubSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.giant),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: const [
                    HubActionButton(label: 'Convidar', icon: Icons.person_add_alt_rounded),
                    HubActionButton(
                      label: 'Criar evento',
                      icon: Icons.add_circle_outline_rounded,
                      filled: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Row(
            children: [
              Expanded(
                child: HubMetricTile(
                  label: 'Membros',
                  value: '${club.members}',
                  icon: Icons.groups_rounded,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: HubMetricTile(
                  label: 'Treinos/semana',
                  value: club.sessionsPerWeek,
                  icon: Icons.sports_score_rounded,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: HubMetricTile(
                  label: 'Eventos/mês',
                  value: club.eventsPerMonth,
                  icon: Icons.event_note_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          const HubTitleRow(title: 'Próximos eventos'),
          const SizedBox(height: AppSpacing.lg),
          ...club.events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: HubSectionCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                onTap: () => context.push(
                  Routes.trainingDetail.replaceFirst(':id', '${20 + index}'),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppPalette.successSoft,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: const Icon(
                        Icons.event_available_rounded,
                        color: AppPalette.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${event.date} · ${event.location}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: const [
              HubMetaChip(label: 'Feed', highlighted: true),
              HubMetaChip(label: 'Eventos'),
              HubMetaChip(label: 'Treinos'),
              HubMetaChip(label: 'Membros'),
              HubMetaChip(label: 'Ranking'),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          HubSectionCard(
            onTap: () => context.push(Routes.postDetail),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: AppPalette.surfaceAlt,
                      child: Text('GT'),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            club.author,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            '2h atrás · Treino · Court 02',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppPalette.textHint,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.giant),
                Text(
                  club.postTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  club.postBody,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.giant),
                Row(
                  children: club.postMetrics
                      .map(
                        (metric) => Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                metric.value,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                metric.label,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppPalette.textHint,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_ClubDetailData _clubFor(String slug) {
  if (slug == 'singles') {
    return const _ClubDetailData(
      name: 'SINGLES SOCIETY',
      members: '84',
      privacy: 'Público',
      tags: ['Tênis', 'Singles', 'Competição'],
      description: 'Grupo para quem curte simples, intensidade e partidas com ranking interno.',
      sessionsPerWeek: '5',
      eventsPerMonth: '4',
      author: 'ana.singles',
      postTitle: 'Sessão de simples com foco tático',
      postBody: 'Muito volume de perna e troca de direção hoje. Ótimo treino para quem quer competir.',
      events: [
        _ClubEvent(title: 'Desafio de Singles', date: 'Amanhã · 7:00', location: 'Court 01'),
        _ClubEvent(title: 'Match Day', date: '26 Mai · 19:30', location: 'Court 04'),
      ],
      postMetrics: [
        _ClubMetric(value: '1h 18m', label: 'Duração'),
        _ClubMetric(value: '510', label: 'kcal'),
        _ClubMetric(value: '4.8 km', label: 'Distância'),
      ],
    );
  }

  return const _ClubDetailData(
    name: 'RALLY CREW',
    members: '125',
    privacy: 'Privado',
    tags: ['Tênis', 'Performance', 'Comunidade'],
    description: 'Grupo focado em evolução constante. Treinos, desafios e uma mentalidade vencedora dentro e fora da quadra.',
    sessionsPerWeek: '8',
    eventsPerMonth: '3',
    author: 'gabriel.tennis',
    postTitle: 'Sessão intensa hoje',
    postBody: 'Foco, consistência e evolução.',
    events: [
      _ClubEvent(title: 'Treino em Grupo', date: 'Amanhã · 7:00', location: 'Court 03'),
      _ClubEvent(title: 'Café & Investimentos', date: '24 Mai · 8:30', location: 'Lounge Galácticos'),
    ],
    postMetrics: [
      _ClubMetric(value: '1h 32m', label: 'Duração'),
      _ClubMetric(value: '642', label: 'kcal'),
      _ClubMetric(value: '6.1 km', label: 'Distância'),
    ],
  );
}

class _ClubDetailData {
  const _ClubDetailData({
    required this.name,
    required this.members,
    required this.privacy,
    required this.tags,
    required this.description,
    required this.sessionsPerWeek,
    required this.eventsPerMonth,
    required this.events,
    required this.author,
    required this.postTitle,
    required this.postBody,
    required this.postMetrics,
  });

  final String name;
  final String members;
  final String privacy;
  final List<String> tags;
  final String description;
  final String sessionsPerWeek;
  final String eventsPerMonth;
  final List<_ClubEvent> events;
  final String author;
  final String postTitle;
  final String postBody;
  final List<_ClubMetric> postMetrics;
}

class _ClubEvent {
  const _ClubEvent({
    required this.title,
    required this.date,
    required this.location,
  });

  final String title;
  final String date;
  final String location;
}

class _ClubMetric {
  const _ClubMetric({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}
