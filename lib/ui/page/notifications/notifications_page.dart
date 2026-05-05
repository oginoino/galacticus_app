import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/notifications_overview.dart';
import '../../../provider/notifications_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/notifications_content.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationsProvider>();
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
          onRetry: provider.loadNotifications,
          retryLabel: sl<AppConstants>().retryLabel,
          child: const SizedBox.shrink(),
        ),
      );
    }

    return AppSliverScaffold(
      title: overview.title,
      subtitle: overview.unreadSummary,
      fallbackRoute: Routes.communities,
      bottomNavigationBar: bottomNav,
      onRefresh: provider.loadNotifications,
      trailing: TextButton(
        onPressed: () =>
            _showSnack(context, overview.messages.markAllReadAction),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          overview.markAllReadLabel,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppPalette.primary,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.bodyLg,
              ),
        ),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: NotificationsContent(
            overview: overview,
            onNotificationTap: () => context.push(Routes.feed),
          ),
        ),
      ],
    );
  }

  void _handleBottomNavigationTap(
    BuildContext context,
    int index,
    NotificationsOverview? overview,
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
