import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/feed_overview.dart';
import '../../../provider/feed_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/feed_content.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FeedProvider>();
    final overview = provider.overview;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationShell(
        currentIndex: 1,
        onSelect: (index) => _handleBottomNavigationTap(context, index, overview),
        homeLabel: overview?.uiLabels.navigationHomeLabel ?? '',
        feedLabel: overview?.uiLabels.navigationFeedLabel ?? '',
        clubsLabel: overview?.uiLabels.navigationClubsLabel ?? '',
        profileLabel: overview?.uiLabels.navigationProfileLabel ?? '',
        onCreateTap: overview == null
            ? null
            : () => _showSnack(context, overview.messages.quickAction),
      ),
      body: ContentStateView(
        isLoading: provider.isLoading && overview == null,
        errorMessage:
            provider.errorMessage != null && overview == null ? provider.errorMessage : null,
        onRetry: provider.loadFeed,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : RefreshIndicator(
                onRefresh: provider.loadFeed,
                color: AppPalette.primary,
                child: FeedContent(
                  overview: overview,
                  onNotificationTap: () => context.push(Routes.notifications),
                  onMessage: (message) => _showSnack(context, message),
                ),
              ),
      ),
    );
  }

  void _handleBottomNavigationTap(
    BuildContext context,
    int index,
    FeedOverview? overview,
  ) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
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
          overview?.messages.quickAction ?? sl<AppConstants>().navigationUnavailableMessage,
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
