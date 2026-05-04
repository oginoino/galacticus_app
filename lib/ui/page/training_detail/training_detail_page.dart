import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../granular/widgets/granular_widgets.dart';

class TrainingDetailPage extends StatelessWidget {
  const TrainingDetailPage({super.key, required this.trainingId});

  final String trainingId;

  @override
  Widget build(BuildContext context) {
    return HubPageScaffold(
      title: 'Match Training',
      subtitle: 'GALÁCTICOS CLUB',
      trailing: const HubMetaChip(label: 'Tennis', highlighted: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HubSectionCard(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppPalette.successSoft, AppPalette.surface],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    HubMetaChip(
                      label: 'Treino #$trainingId',
                      icon: Icons.sports_tennis_rounded,
                    ),
                    const HubMetaChip(label: 'Maio 2025'),
                  ],
                ),
                const SizedBox(height: AppSpacing.giant),
                Text(
                  '1h 40m',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: AppLetterSpacing.tightXl,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Duração',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppPalette.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.giant),
                Row(
                  children: const [
                    Expanded(
                      child: HubMetricTile(
                        label: 'Duração',
                        value: '1h 40m',
                        icon: Icons.timer_outlined,
                        highlighted: true,
                      ),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: HubMetricTile(
                        label: 'Cal',
                        value: '830',
                        icon: Icons.local_fire_department_outlined,
                      ),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: HubMetricTile(
                        label: 'Dist',
                        value: '7.1 km',
                        icon: Icons.route_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.giant),
                Text(
                  'Quadra 03 · Unidade Alpha',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '25°C · São Paulo, BR',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppPalette.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Frequência Cardíaca',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppPalette.textHint,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Row(
            children: const [
              Expanded(
                child: HubMetricTile(
                  label: 'Média',
                  value: '155 bpm',
                  icon: Icons.favorite_border_rounded,
                ),
              ),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: HubMetricTile(
                  label: 'Máx',
                  value: '189 bpm',
                  icon: Icons.monitor_heart_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          HubSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HubTitleRow(title: 'Intensidade'),
                const SizedBox(height: AppSpacing.giant),
                Row(
                  children: const [
                    Expanded(
                      child: HubMetricTile(
                        label: 'Tempo ativo',
                        value: '1h 40m',
                        icon: Icons.bolt_rounded,
                      ),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: HubMetricTile(
                        label: 'Distância',
                        value: '7.1 km',
                        icon: Icons.straighten_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
