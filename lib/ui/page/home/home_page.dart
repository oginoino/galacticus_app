import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/community_event.dart';
import '../../../domain/dashboard_overview.dart';
import '../../../domain/match_invite.dart';
import '../../../domain/quick_access_item.dart';
import '../../../provider/home_provider.dart';
import '../../../route/routes/routes.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import '../../../util/const/app_constants.dart';
import 'widgets/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final overview = provider.overview;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationShell(
        currentIndex: 0,
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
        errorMessage: provider.errorMessage != null && overview == null
            ? provider.errorMessage
            : null,
        onRetry: provider.loadDashboard,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : RefreshIndicator(
                onRefresh: provider.loadDashboard,
                color: AppPalette.primary,
                child: HomeContent(
                  overview: overview,
                  onNotificationTap: () => context.push(Routes.notifications),
                  onBookingTap: () => context.push(Routes.booking),
                  onAssistantTap: () => context.push(Routes.assistant),
                  onWorkoutTap: () => context.push(Routes.checkin),
                  onLessonsTap: () => context.push(Routes.lessons),
                  onAgendasTap: () => context.push(Routes.agendas),
                  onRankingTap: () => context.push(Routes.ranking),
                  onQuickAccessTap: (item) =>
                      _handleQuickAccessTap(context, item, overview),
                  onExploreTap: (event) => _handleExploreTap(context, event),
                  onInviteTap: (invite) => _handleInviteTap(context, invite),
                  onMessage: (message) => _showSnack(context, message),
                ),
              ),
      ),
    );
  }

  void _handleBottomNavigationTap(
    BuildContext context,
    int index,
    DashboardOverview? overview,
  ) {
    switch (index) {
      case 0:
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
          overview?.messages.quickAction ?? sl<AppConstants>().navigationUnavailableMessage,
        );
    }
  }

  void _handleQuickAccessTap(
    BuildContext context,
    QuickAccessItem item,
    DashboardOverview overview,
  ) {
    if (item.type == 'check') {
      context.push(Routes.checkin);
      return;
    }

    if (item.type == 'ranking') {
      context.push(Routes.ranking);
      return;
    }

    if (item.type == 'chart') {
      context.push(Routes.progress);
      return;
    }

    if (item.type == 'shooting') {
      context.push(Routes.shooting);
      return;
    }

    if (item.type == 'sports') {
      context.push(Routes.matches);
      return;
    }

    if (item.type == 'clubs') {
      context.push(Routes.clubDetail.replaceFirst(':slug', 'rally'));
      return;
    }

    if (item.type == 'event') {
      context.push(Routes.trainingDetail.replaceFirst(':id', '14'));
      return;
    }

    if (item.type == 'calendar') {
      context.push(Routes.agendas);
      return;
    }

    _showSnack(context, overview.messages.quickAction);
  }

  void _handleExploreTap(BuildContext context, CommunityEvent event) {
    final title = event.title.toLowerCase();
    if (title.contains('aula') || title.contains('coach')) {
      context.push(Routes.trainingDetail.replaceFirst(':id', '14'));
      return;
    }

    if (title.contains('padel')) {
      context.push(Routes.clubDetail.replaceFirst(':slug', 'rally'));
      return;
    }

    context.push(Routes.matches);
  }

  void _handleInviteTap(BuildContext context, MatchInvite invite) {
    context.push(Routes.matches);
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
