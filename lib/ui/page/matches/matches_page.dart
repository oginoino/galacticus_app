import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/match_overview.dart';
import '../../../provider/matches_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/matches_widgets.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MatchesProvider>();
    final overview = provider.overview;

    return AppSliverScaffold(
      title: overview?.title ?? '',
      subtitle: overview?.subtitle,
      slivers: [
        SliverToBoxAdapter(
          child: ContentStateView(
            isLoading: provider.isLoading && overview == null,
            errorMessage: provider.errorMessage != null && overview == null
                ? provider.errorMessage
                : null,
            onRetry: provider.loadMatches,
            retryLabel: sl<AppConstants>().retryLabel,
            child: overview == null
                ? const SizedBox.shrink()
                : _buildContent(context, overview, provider),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    MatchOverview overview,
    MatchesProvider provider,
  ) {
    final visible = provider.visibleItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.lg),
        MatchesFilterRow(
          filters: overview.filters,
          selectedIndex: provider.selectedFilterIndex,
          onTap: provider.selectFilter,
        ),
        const SizedBox(height: AppSpacing.section),
        if (visible.isEmpty)
          Padding(
            padding: AppInsets.pageHorizontal,
            child: Text(
              overview.emptyLabel,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textMuted,
                  ),
            ),
          )
        else
          Padding(
            padding: AppInsets.pageHorizontal,
            child: Column(
              children: [
                for (final match in visible) ...[
                  MatchCard(
                    match: match,
                    onTap: () => context.push(
                      Routes.trainingDetail.replaceFirst(':id', match.id),
                    ),
                  ),
                  if (match != visible.last)
                    const SizedBox(height: AppSpacing.lg),
                ],
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.section),
      ],
    );
  }
}
