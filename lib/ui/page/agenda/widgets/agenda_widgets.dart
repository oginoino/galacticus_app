import 'package:flutter/material.dart';

import '../../../../domain/community_event.dart';
import '../../../../domain/match_invite.dart';
import '../../../theme/app_theme.dart';

class AgendaSectionTitle extends StatelessWidget {
  const AgendaSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: AppFontSize.title,
          ),
    );
  }
}

class AgendaEventsList extends StatelessWidget {
  const AgendaEventsList({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<CommunityEvent> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: AppResponsiveInsets.listItemGap(item == items.last),
              child: _AgendaEventCard(
                item: item,
                onTap: onTap,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class AgendaMatchesList extends StatelessWidget {
  const AgendaMatchesList({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<MatchInvite> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: AppResponsiveInsets.listItemGap(item == items.last),
              child: _AgendaMatchCard(
                item: item,
                onTap: onTap,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _AgendaEventCard extends StatelessWidget {
  const _AgendaEventCard({
    required this.item,
    required this.onTap,
  });

  final CommunityEvent item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: SizedBox(
        height: AppSize.agendaEventCardHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(item.imageAsset, fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.lg),
                      AppPalette.black.withValues(alpha: AppOpacity.overlay),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: AppInsets.cardPaddingLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _AgendaBadge(label: item.tag),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.headingSm,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppPalette.textMuted,
                            fontSize: AppFontSize.body,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgendaMatchCard extends StatelessWidget {
  const _AgendaMatchCard({
    required this.item,
    required this.onTap,
  });

  final MatchInvite item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: AppInsets.cardPaddingLg,
        decoration: BoxDecoration(
          color: AppPalette.surfaceDeep,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: AppSize.agendaMatchAvatar / 2,
              backgroundImage: AssetImage(item.avatarAsset),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.hostName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.title,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${item.sport} · ${item.schedule}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.body,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.bodySm,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _AgendaBadge(
                    label: item.availability,
                    highlighted: item.isLastSpot,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Icon(
              Icons.chevron_right_rounded,
              color: AppPalette.white.withValues(alpha: AppOpacity.strong),
              size: AppIconSize.xxl,
            ),
          ],
        ),
      ),
    );
  }
}

class _AgendaBadge extends StatelessWidget {
  const _AgendaBadge({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.pillPadding,
      decoration: BoxDecoration(
        color: highlighted
            ? AppPalette.primary.withValues(alpha: AppOpacity.xs)
            : AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppPalette.primary : AppPalette.white,
          fontWeight: FontWeight.w700,
          fontSize: AppFontSize.labelLg,
        ),
      ),
    );
  }
}
