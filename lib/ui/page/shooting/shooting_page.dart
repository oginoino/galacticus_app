import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../granular/widgets/granular_widgets.dart';

class ShootingPage extends StatefulWidget {
  const ShootingPage({super.key});

  @override
  State<ShootingPage> createState() => _ShootingPageState();
}

class _ShootingPageState extends State<ShootingPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    const photos = [
      _ShotItem(date: '8 Abr', sport: '🎾', court: 'Quadra 02'),
      _ShotItem(date: '8 Abr', sport: '🏸', court: 'Quadra 05'),
      _ShotItem(date: '7 Abr', sport: '🎾', court: 'Quadra 01'),
      _ShotItem(date: '7 Abr', sport: '🏸', court: 'Quadra 03'),
      _ShotItem(date: '6 Abr', sport: '🎾', court: 'Quadra 02'),
      _ShotItem(date: '5 Abr', sport: '🏸', court: 'Quadra 04'),
    ];

    return HubPageScaffold(
      title: 'Shooting',
      subtitle: 'GALÁCTICOS CLUB',
      trailing: const HubMetaChip(label: 'Modo Shooting', highlighted: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HubSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Modo Shooting',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Ative para ser fotografado',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _enabled,
                      activeThumbColor: AppPalette.primary,
                      onChanged: (value) => setState(() => _enabled = value),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.giant),
                Container(
                  height: 112,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.xxxl),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppPalette.successSoft, AppPalette.surfaceAlt],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 42,
                      color: AppPalette.primary.withValues(alpha: AppOpacity.heavy),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Row(
            children: const [
              Expanded(
                child: HubMetricTile(label: 'Liberadas', value: '2', icon: Icons.lock_open_rounded),
              ),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: HubMetricTile(label: 'Bloqueadas', value: '4', icon: Icons.lock_outline_rounded),
              ),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: HubMetricTile(label: 'Total', value: '6', icon: Icons.photo_library_outlined),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          const HubTitleRow(title: 'Suas Fotos', action: '6 fotos'),
          const SizedBox(height: AppSpacing.lg),
          ...photos.map(
            (photo) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: HubSectionCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        gradient: const LinearGradient(
                          colors: [AppPalette.surfaceAlt, AppPalette.surface],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          photo.sport,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            photo.date,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            photo.court,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppPalette.textHint,
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

class _ShotItem {
  const _ShotItem({
    required this.date,
    required this.sport,
    required this.court,
  });

  final String date;
  final String sport;
  final String court;
}
