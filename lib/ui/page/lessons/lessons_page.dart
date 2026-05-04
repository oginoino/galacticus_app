import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/lessons_overview.dart';
import '../../../provider/lessons_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import 'widgets/lessons_content.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LessonsProvider>();
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
            : () => _showSnack(context, overview.messages.trackAction),
      ),
      body: ContentStateView(
        isLoading: provider.isLoading && overview == null,
        errorMessage:
            provider.errorMessage != null && overview == null ? provider.errorMessage : null,
        onRetry: provider.loadLessons,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : LessonsContent(
                overview: overview,
                onBackTap: () {
                  if (context.canPop()) {
                    context.pop();
                    return;
                  }

                  context.go(Routes.home);
                },
                onFeaturedTap: () => context.push(Routes.aiTraining),
                onTrackTap: () => context.push(Routes.aiTraining),
                onUpcomingTap: () => context.push(Routes.aiTraining),
              ),
      ),
    );
  }

  void _handleBottomNavigationTap(
    BuildContext context,
    int index,
    LessonsOverview? overview,
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
          overview?.messages.trackAction ?? sl<AppConstants>().navigationUnavailableMessage,
        );
    }
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
