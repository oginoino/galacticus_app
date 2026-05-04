import 'package:flutter/material.dart';

import '../granular/widgets/granular_widgets.dart';
import '../../theme/app_theme.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const matches = [
      _MatchItem(
        sport: 'Tennis',
        relativeTime: 'Hoje',
        status: 'Confirmado',
        players: ['PH', 'CM'],
        score: '6-4, 7-5',
        highlighted: true,
      ),
      _MatchItem(
        sport: 'Padel',
        relativeTime: 'Ontem',
        status: 'Confirmado',
        players: ['PH', 'AL', 'PS', 'JR'],
        score: '6-3, 6-4',
      ),
      _MatchItem(
        sport: 'Tennis',
        relativeTime: '3 dias atrás',
        status: 'Pendente',
        players: ['PH', 'RB'],
        score: '3-6, 7-6, 6-4',
      ),
    ];

    return HubPageScaffold(
      title: 'Partidas',
      subtitle: 'Histórico e registro',
      trailing: const HubMetaChip(
        label: 'Filtrar',
        icon: Icons.tune_rounded,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: const [
              HubMetaChip(label: 'Tennis', highlighted: true),
              HubMetaChip(label: 'Padel'),
              HubMetaChip(label: 'Confirmadas'),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          ...matches.map(
            (match) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: HubSectionCard(
                padding: const EdgeInsets.all(AppSpacing.page),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: match.sport,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppPalette.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                TextSpan(
                                  text: '  ${match.relativeTime}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppPalette.textHint,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        HubMetaChip(
                          label: match.status,
                          highlighted: match.highlighted,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.huge),
                    Row(
                      children: [
                        HubPeopleStack(people: match.players),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.surfaceAlt,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            match.score,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchItem {
  const _MatchItem({
    required this.sport,
    required this.relativeTime,
    required this.status,
    required this.players,
    required this.score,
    this.highlighted = false,
  });

  final String sport;
  final String relativeTime;
  final String status;
  final List<String> players;
  final String score;
  final bool highlighted;
}
