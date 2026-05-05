import 'package:flutter/material.dart';

import '../../../../domain/match_filter_chip.dart';
import '../../../../domain/match_player.dart';
import '../../../../domain/match_record.dart';
import '../../../theme/app_theme.dart';

class MatchesFilterRow extends StatelessWidget {
  const MatchesFilterRow({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<MatchFilterChip> filters;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: AppInsets.pageHorizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final selected = index == selectedIndex;
          return Padding(
            padding: EdgeInsets.only(
              right: index == filters.length - 1 ? 0 : AppSpacing.md,
            ),
            child: _FilterChip(
              label: filters[index].label,
              selected: selected,
              onTap: () => onTap(index),
            ),
          );
        }),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? AppPalette.primary : AppPalette.surfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected
                  ? AppPalette.primary
                  : AppPalette.white.withValues(alpha: AppOpacity.xxs),
              width: AppStroke.hairline,
            ),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? AppPalette.black : AppPalette.white,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: AppFontSize.bodyLg,
                ),
          ),
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  final MatchRecord match;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.page),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
              width: AppStroke.hairline,
            ),
          ),
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
                          match.sportLabel,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPalette.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.titleLg,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          '${match.dateLabel} · ${match.relativeTime}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppPalette.textHint,
                                    fontSize: AppFontSize.body,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  _StatusPill(
                    label: match.statusLabel,
                    highlighted: match.statusHighlighted,
                  ),
                ],
              ),
              if (match.locationLabel != null) ...[
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppPalette.textMuted,
                      size: AppIconSize.md,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        match.locationLabel!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textMuted,
                                  fontSize: AppFontSize.body,
                                ),
                      ),
                    ),
                    if (match.durationLabel != null) ...[
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        match.durationLabel!,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppPalette.textHint,
                                  fontSize: AppFontSize.body,
                                ),
                      ),
                    ],
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.giant),
              Row(
                children: [
                  Expanded(child: MatchPlayersStack(players: match.players)),
                  const SizedBox(width: AppSpacing.lg),
                  if (match.resultBadge != null) ...[
                    _ResultBadge(label: match.resultBadge!),
                    const SizedBox(width: AppSpacing.md),
                  ],
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
                      match.scoreLabel,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: AppFontSize.titleSm,
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.highlighted});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.successSoft : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: highlighted
              ? AppPalette.primary.withValues(alpha: AppOpacity.quarter)
              : AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: highlighted ? AppPalette.primary : AppPalette.textMuted,
              fontWeight: FontWeight.w600,
              fontSize: AppFontSize.bodySm,
              letterSpacing: AppLetterSpacing.wideSm,
            ),
      ),
    );
  }
}

class _ResultBadge extends StatelessWidget {
  const _ResultBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isWin = label.toLowerCase().contains('vit');
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isWin
            ? AppPalette.primary.withValues(alpha: AppOpacity.medium)
            : AppPalette.danger.withValues(alpha: AppOpacity.medium),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isWin ? AppPalette.primary : AppPalette.danger,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.bodySm,
              letterSpacing: AppLetterSpacing.wideSm,
            ),
      ),
    );
  }
}

class MatchPlayersStack extends StatelessWidget {
  const MatchPlayersStack({super.key, required this.players});

  final List<MatchPlayer> players;

  @override
  Widget build(BuildContext context) {
    final visible = players.take(4).toList(growable: false);
    return SizedBox(
      height: 32,
      child: Stack(
        children: List.generate(visible.length, (i) {
          final player = visible[i];
          return Positioned(
            left: i * 22.0,
            child: _PlayerAvatar(player: player),
          );
        }),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  const _PlayerAvatar({required this.player});

  final MatchPlayer player;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.surfaceAlt,
        border: Border.all(
          color: AppPalette.background,
          width: AppStroke.thick,
        ),
        image: player.avatarAsset != null
            ? DecorationImage(
                image: AssetImage(player.avatarAsset!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: player.avatarAsset == null
          ? Text(
              player.initials,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.label,
                  ),
            )
          : null,
    );
  }
}
