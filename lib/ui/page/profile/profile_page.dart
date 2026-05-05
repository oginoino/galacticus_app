import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/profile_menu_item.dart';
import '../../../domain/profile_overview.dart';
import '../../../provider/profile_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/bottom_navigation_shell.dart';
import '../../components/content_state_view.dart';
import '../../components/profile_menu_bottom_sheet.dart';
import '../../theme/app_theme.dart';
import 'widgets/profile_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final overview = provider.overview;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationShell(
        currentIndex: 3,
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
        onRetry: provider.loadProfile,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : RefreshIndicator(
                onRefresh: provider.loadProfile,
                color: AppPalette.primary,
                child: ProfileContent(
                  overview: overview,
                  onBackTap: () => context.go(Routes.home),
                  onMoreTap: () => _openMenu(context, overview),
                  onSocialTap: () => _showSnack(context, overview.messages.socialAction),
                  onTabTap: () => _showSnack(context, overview.messages.tabAction),
                  onGalleryTap: () => _showSnack(context, overview.messages.galleryAction),
                ),
              ),
      ),
    );
  }

  void _handleBottomNavigationTap(
    BuildContext context,
    int index,
    ProfileOverview? overview,
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
        break;
      default:
        _showSnack(
          context,
          overview?.messages.quickAction ?? sl<AppConstants>().navigationUnavailableMessage,
        );
    }
  }

  void _openMenu(BuildContext context, ProfileOverview overview) {
    ProfileMenuBottomSheet.show(
      context,
      items: overview.menuItems,
      onItemTap: (item) => _handleMenuTap(context, item, overview),
    );
  }

  void _handleMenuTap(
    BuildContext context,
    ProfileMenuItem item,
    ProfileOverview overview,
  ) {
    if (item.isDestructive) {
      _showSnack(context, overview.messages.logoutAction);
      return;
    }

    _showSnack(
      context,
      '${item.label} · ${overview.messages.menuTapAction}',
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
