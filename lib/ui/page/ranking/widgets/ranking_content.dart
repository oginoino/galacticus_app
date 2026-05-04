import 'package:flutter/material.dart';

import '../../../../domain/ranking_overview.dart';
import '../../../theme/app_theme.dart';
import 'ranking_widgets.dart';

class RankingContent extends StatelessWidget {
  const RankingContent({
    super.key,
    required this.overview,
    required this.selectedCategoryId,
    required this.onBackTap,
    required this.onCategoryTap,
    required this.onEntryTap,
  });

  final RankingOverview overview;
  final String? selectedCategoryId;
  final VoidCallback onBackTap;
  final ValueChanged<String> onCategoryTap;
  final VoidCallback onEntryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RankingHeader(
          overview: overview,
          onBackTap: onBackTap,
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: AppInsets.rankingPage,
            children: [
              RankingCategoryTabs(
                items: overview.categories,
                selectedCategoryId: selectedCategoryId,
                onTap: onCategoryTap,
              ),
              const SizedBox(height: AppSpacing.sectionLg),
              RankingPodium(overview: overview),
              const SizedBox(height: AppSpacing.sectionLg),
              RankingEntriesList(
                items: overview.entries,
                onTap: onEntryTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
