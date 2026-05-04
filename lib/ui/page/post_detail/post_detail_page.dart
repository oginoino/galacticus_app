import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../granular/widgets/granular_widgets.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const comments = [
      _CommentItem(author: 'paula.rally', time: '24 min', message: 'Muito forte. Essa sessão rendeu demais.'),
      _CommentItem(author: 'coach.mateus', time: '18 min', message: 'Boa consistência de ritmo. Vamos repetir no próximo bloco.'),
      _CommentItem(author: 'gui.tennis', time: '9 min', message: 'Essa quadra estava rápida hoje.'),
    ];

    return HubPageScaffold(
      title: 'Post',
      subtitle: 'Detalhe da publicação',
      trailing: const HubMetaChip(
        label: 'Treino',
        highlighted: true,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HubSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppPalette.surfaceAlt,
                      child: Text('GT'),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'gabriel.tennis',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            '2h atrás · Court 02',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppPalette.textHint,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_horiz_rounded, color: AppPalette.textHint),
                  ],
                ),
                const SizedBox(height: AppSpacing.giant),
                Text(
                  'Sessão intensa hoje',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Foco, consistência e evolução.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: const [
                    HubMetaChip(label: 'Treino', highlighted: true),
                    HubMetaChip(label: 'Court 02'),
                  ],
                ),
                const SizedBox(height: AppSpacing.giant),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.xxxl),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppPalette.surfaceAlt, AppPalette.successDark],
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 20,
                        right: 20,
                        child: HubMetaChip(
                          label: 'Treino',
                          highlighted: true,
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.sports_tennis_rounded,
                          size: 72,
                          color: AppPalette.primary.withValues(alpha: AppOpacity.half),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.giant),
                Row(
                  children: const [
                    Expanded(
                      child: HubMetricTile(label: 'Duração', value: '1h 32m'),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: HubMetricTile(label: 'kcal', value: '642'),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: HubMetricTile(label: 'Distância', value: '6.1 km'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Row(
            children: const [
              HubMetaChip(label: '245 curtidas', icon: Icons.favorite_border_rounded),
              SizedBox(width: AppSpacing.md),
              HubMetaChip(label: '18 comentários', icon: Icons.chat_bubble_outline_rounded),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          const HubTitleRow(title: 'Comentários'),
          const SizedBox(height: AppSpacing.lg),
          ...comments.map(
            (comment) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: HubSectionCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            comment.author,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        Text(
                          comment.time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppPalette.textHint,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      comment.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppPalette.textSecondary,
                          ),
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

class _CommentItem {
  const _CommentItem({
    required this.author,
    required this.time,
    required this.message,
  });

  final String author;
  final String time;
  final String message;
}
