import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/ranking_overview.dart';
import '../../../provider/ranking_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import 'widgets/ranking_content.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RankingProvider>();
    final overview = provider.overview;

    final bottomNav = BottomNavigationShell(
      currentIndex: -1,
      onSelect: (index) => _handleBottomNavigationTap(context, index, overview),
      homeLabel: overview?.uiLabels.navigationHomeLabel ?? '',
      feedLabel: overview?.uiLabels.navigationFeedLabel ?? '',
      clubsLabel: overview?.uiLabels.navigationClubsLabel ?? '',
      profileLabel: overview?.uiLabels.navigationProfileLabel ?? '',
      onCreateTap: overview == null
          ? null
          : () => _showSnack(context, overview.messages.quickAction),
    );

    if (overview == null) {
      return Scaffold(
        bottomNavigationBar: bottomNav,
        body: ContentStateView(
          isLoading: provider.isLoading,
          errorMessage: provider.errorMessage,
          onRetry: provider.loadRanking,
          retryLabel: sl<AppConstants>().retryLabel,
          child: const SizedBox.shrink(),
        ),
      );
    }

    return AppSliverScaffold(
      title: overview.title,
      subtitle: overview.subtitle,
      bottomNavigationBar: bottomNav,
      onRefresh: provider.loadRanking,
      slivers: [
        SliverToBoxAdapter(
          child: RankingContent(
            overview: overview,
            selectedCategoryId: provider.selectedCategoryId,
            onCategoryTap: (categoryId) {
              provider.selectCategory(categoryId);
              _showSnack(context, overview.messages.categoryAction);
            },
            onEntryTap: () =>
                _showSnack(context, overview.messages.entryAction),
          ),
        ),
      ],
    );
  }

  void _handleBottomNavigationTap(
    BuildContext context,
    int index,
    RankingOverview? overview,
  ) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
        context.go(Routes.feed);
        break;
      case 2:
        context.go(Routes.communities);
        break;
      case 3:
        context.go(Routes.profile);
        break;
      default:
        _showSnack(
          context,
          overview?.messages.quickAction ??
              sl<AppConstants>().navigationUnavailableMessage,
        );
    }
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
