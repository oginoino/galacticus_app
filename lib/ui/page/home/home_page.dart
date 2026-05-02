import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/home_provider.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final overview = provider.overview;

    return Scaffold(
      bottomNavigationBar: BottomNavigationShell(
        currentIndex: provider.selectedTabIndex,
        onSelect: provider.selectTab,
        onCreateTap: () => _showSnack(
          context,
          'Ação rápida disponível na próxima iteração.',
        ),
      ),
      body: SafeArea(
        child: ContentStateView(
          isLoading: provider.isLoading && overview == null,
          errorMessage: provider.errorMessage != null && overview == null
              ? provider.errorMessage
              : null,
          onRetry: provider.loadDashboard,
          child: overview == null
              ? const SizedBox.shrink()
              : RefreshIndicator(
                  onRefresh: provider.loadDashboard,
                  color: AppPalette.primary,
                  child: HomeContent(
                    overview: overview,
                    onMessage: (message) => _showSnack(context, message),
                  ),
                ),
        ),
      ),
    );
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
