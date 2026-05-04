import 'package:flutter/material.dart';

import '../../../../domain/ranking_category.dart';
import '../../../../domain/ranking_list_entry.dart';
import '../../../../domain/ranking_overview.dart';
import '../../../../domain/ranking_podium_entry.dart';
import '../../../theme/app_theme.dart';

class RankingHeader extends StatelessWidget {
  const RankingHeader({
    super.key,
    required this.overview,
    required this.onBackTap,
  });

  final RankingOverview overview;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSize.rankingHeaderLeadingInset,
        topInset + AppSpacing.page,
        AppSpacing.page,
        AppSpacing.lg,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: onBackTap,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    width: AppSize.rankingTopAction,
                    height: AppSize.rankingTopAction,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPalette.surfaceAlt,
                      border: Border.all(
                        color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                        width: AppStroke.hairline,
                      ),
                    ),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      color: AppPalette.white,
                      size: AppIconSize.huge,
                    ),
                  ),
                ),
              ),
              Text(
                overview.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.heading,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            overview.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.bodyLg,
                ),
          ),
        ],
      ),
    );
  }
}

class RankingCategoryTabs extends StatelessWidget {
  const RankingCategoryTabs({
    super.key,
    required this.items,
    required this.selectedCategoryId,
    required this.onTap,
  });

  final List<RankingCategory> items;
  final String? selectedCategoryId;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (item) => Padding(
                padding: EdgeInsets.only(
                  right: item == items.last ? 0 : AppSpacing.sm,
                ),
                child: InkWell(
                  onTap: () => onTap(item.id),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    height: AppSize.rankingCategoryHeight,
                    padding: AppInsets.actionChipPadding,
                    decoration: BoxDecoration(
                      color: item.id == selectedCategoryId
                          ? AppPalette.white
                          : AppPalette.black,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(
                        color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                        width: AppStroke.hairline,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: item.id == selectedCategoryId
                                ? AppPalette.black
                                : AppPalette.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class RankingPodium extends StatelessWidget {
  const RankingPodium({
    super.key,
    required this.overview,
  });

  final RankingOverview overview;

  @override
  Widget build(BuildContext context) {
    if (overview.podiumEntries.length < 3) {
      return const SizedBox.shrink();
    }

    final second = overview.podiumEntries[0];
    final first = overview.podiumEntries[1];
    final third = overview.podiumEntries[2];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RankingPodiumColumn(entry: second, winner: false),
        const SizedBox(width: AppSpacing.md),
        _RankingPodiumColumn(entry: first, winner: true),
        const SizedBox(width: AppSpacing.md),
        _RankingPodiumColumn(entry: third, winner: false),
      ],
    );
  }
}

class RankingEntriesList extends StatelessWidget {
  const RankingEntriesList({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<RankingListEntry> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: AppResponsiveInsets.listItemGap(item == items.last),
              child: _RankingEntryCard(
                item: item,
                highlighted: item.position <= 3,
                onTap: onTap,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _RankingPodiumColumn extends StatelessWidget {
  const _RankingPodiumColumn({
    required this.entry,
    required this.winner,
  });

  final RankingPodiumEntry entry;
  final bool winner;

  @override
  Widget build(BuildContext context) {
    final height = winner
        ? AppSize.rankingPodiumCardHeightWinner
        : AppSize.rankingPodiumCardHeight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSize.rankingPodiumAvatar,
          height: AppSize.rankingPodiumAvatar,
          decoration: BoxDecoration(
            color: winner ? AppPalette.primary : AppPalette.surfaceAlt,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            entry.initials as String,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: winner ? AppPalette.black : AppPalette.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          entry.name as String,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.bodyLg,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: AppSize.rankingPodiumCardWidth,
          height: height,
          decoration: BoxDecoration(
            color: winner
                ? AppPalette.primary.withValues(alpha: AppOpacity.sm)
                : AppPalette.surfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          padding: AppInsets.rankingPodiumCardPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                entry.positionLabel as String,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: winner ? AppPalette.primary : AppPalette.white,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.label,
                    ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                '${entry.points}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.title,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RankingEntryCard extends StatelessWidget {
  const _RankingEntryCard({
    required this.item,
    required this.highlighted,
    required this.onTap,
  });

  final RankingListEntry item;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: AppInsets.cardPaddingMd,
        decoration: BoxDecoration(
          color: AppPalette.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            SizedBox(
              width: AppSize.rankingPositionWidth,
              child: Text(
                '#${item.position}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: highlighted ? AppPalette.primary : AppPalette.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              width: AppSize.rankingListAvatar,
              height: AppSize.rankingListAvatar,
              decoration: BoxDecoration(
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                item.initials,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppFontSize.bodyLg,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    item.levelLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.body,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              '${item.points}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppFontSize.bodyLg,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
