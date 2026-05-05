import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/shooting_overview.dart';
import '../../../provider/shooting_provider.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/shooting_widgets.dart';

class ShootingPage extends StatelessWidget {
  const ShootingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShootingProvider>();
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
            onRetry: provider.loadShooting,
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
    ShootingOverview overview,
    ShootingProvider provider,
  ) {
    return Padding(
      padding: AppInsets.pageHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          ShootingModeCard(
            label: overview.modeLabel,
            helpTitle: overview.helpTitle,
            helpText: overview.helpText,
            enabled: provider.modeEnabled,
            onChanged: (_) => provider.toggleMode(),
          ),
          const SizedBox(height: AppSpacing.section),
          Text(
            overview.galleryTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.titleLg,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ShotsGrid(
            items: overview.items,
            onItemTap: (_) {},
          ),
          const SizedBox(height: AppSpacing.section),
        ],
      ),
    );
  }
}
