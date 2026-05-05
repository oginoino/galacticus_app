import 'package:flutter/material.dart';

import '../../../../domain/training_comment.dart';
import '../../../../domain/training_hero.dart';
import '../../../../domain/training_metric.dart';
import '../../../theme/app_theme.dart';

class TrainingHeroCard extends StatelessWidget {
  const TrainingHeroCard({super.key, required this.hero});

  final TrainingHero hero;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.giant),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppPalette.successSoft, AppPalette.surface],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppPalette.primary.withValues(alpha: AppOpacity.medium),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              _iconFor(hero.iconKey),
              color: AppPalette.primary,
              size: AppIconSize.giant,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hero.primaryLabel,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppFontSize.headingSm,
                      ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '${hero.secondaryLabel} · ${hero.tertiaryLabel}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textMuted,
                        fontSize: AppFontSize.bodyLg,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'tennis':
        return Icons.sports_tennis_rounded;
      case 'padel':
        return Icons.sports_baseball_rounded;
      case 'run':
        return Icons.directions_run_rounded;
      case 'beach':
        return Icons.beach_access_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }
}

class TrainingChipsRow extends StatelessWidget {
  const TrainingChipsRow({super.key, required this.chips});

  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: chips
          .map(
            (chip) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppPalette.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                  width: AppStroke.hairline,
                ),
              ),
              child: Text(
                chip,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.textSecondary,
                      fontSize: AppFontSize.bodySm,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class TrainingMetricsGrid extends StatelessWidget {
  const TrainingMetricsGrid({super.key, required this.metrics});

  final List<TrainingMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 2.4,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) =>
          TrainingMetricTile(metric: metrics[index]),
    );
  }
}

class TrainingMetricTile extends StatelessWidget {
  const TrainingMetricTile({super.key, required this.metric});

  final TrainingMetric metric;

  @override
  Widget build(BuildContext context) {
    final delta = metric.delta;
    final trend = metric.trend;
    final deltaColor = trend == 'down'
        ? AppPalette.danger
        : trend == 'up'
            ? AppPalette.primary
            : AppPalette.textMuted;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.label,
                  letterSpacing: AppLetterSpacing.wideSm,
                ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                metric.value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFontSize.titleLg,
                      height: 1,
                    ),
              ),
              if (delta != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
                  child: Text(
                    delta,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: deltaColor,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.label,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class TrainingNotesSection extends StatelessWidget {
  const TrainingNotesSection({
    super.key,
    required this.title,
    required this.notes,
  });

  final String title;
  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.giant),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
              width: AppStroke.hairline,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final note in notes) ...[
                if (note != notes.first) const SizedBox(height: AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPalette.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        note,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textSecondary,
                                  fontSize: AppFontSize.bodyLg,
                                  height: 1.4,
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class TrainingCommentsList extends StatelessWidget {
  const TrainingCommentsList({
    super.key,
    required this.title,
    required this.comments,
  });

  final String title;
  final List<TrainingComment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final comment in comments) ...[
          if (comment != comments.first)
            const SizedBox(height: AppSpacing.md),
          TrainingCommentCard(comment: comment),
        ],
      ],
    );
  }
}

class TrainingCommentCard extends StatelessWidget {
  const TrainingCommentCard({super.key, required this.comment});

  final TrainingComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentAvatar(comment: comment),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
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
                              fontSize: AppFontSize.bodyLg,
                            ),
                      ),
                    ),
                    Text(
                      comment.timeLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppPalette.textHint,
                            fontSize: AppFontSize.bodySm,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  comment.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textSecondary,
                        fontSize: AppFontSize.bodyLg,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentAvatar extends StatelessWidget {
  const _CommentAvatar({required this.comment});

  final TrainingComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.surfaceAlt,
        image: comment.avatarAsset != null
            ? DecorationImage(
                image: AssetImage(comment.avatarAsset!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: comment.avatarAsset == null
          ? Text(
              comment.initials ?? '·',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.bodySm,
                  ),
            )
          : null,
    );
  }
}
