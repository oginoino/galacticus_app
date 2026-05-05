import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/training_detail_overview.dart';
import '../../../provider/training_detail_provider.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/training_detail_widgets.dart';

class TrainingDetailPage extends StatefulWidget {
  const TrainingDetailPage({super.key, required this.trainingId});

  final String trainingId;

  @override
  State<TrainingDetailPage> createState() => _TrainingDetailPageState();
}

class _TrainingDetailPageState extends State<TrainingDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TrainingDetailProvider>()
          .loadTraining(id: widget.trainingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TrainingDetailProvider>();
    final overview = provider.overview;

    return AppSliverScaffold(
      title: overview?.title ?? '',
      subtitle: overview?.dateLabel,
      slivers: [
        SliverToBoxAdapter(
          child: ContentStateView(
            isLoading: provider.isLoading && overview == null,
            errorMessage: provider.errorMessage != null && overview == null
                ? provider.errorMessage
                : null,
            onRetry: () => provider.loadTraining(id: widget.trainingId),
            retryLabel: sl<AppConstants>().retryLabel,
            child: overview == null
                ? const SizedBox.shrink()
                : _buildContent(context, overview),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, TrainingDetailOverview overview) {
    return Padding(
      padding: AppInsets.pageHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          TrainingHeroCard(hero: overview.hero),
          const SizedBox(height: AppSpacing.section),
          TrainingChipsRow(chips: overview.chips),
          const SizedBox(height: AppSpacing.section),
          Text(
            overview.summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textSecondary,
                  fontSize: AppFontSize.bodyLg,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: AppSpacing.section),
          Text(
            overview.metricsTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.titleLg,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TrainingMetricsGrid(metrics: overview.metrics),
          const SizedBox(height: AppSpacing.section),
          TrainingNotesSection(
            title: overview.notesTitle,
            notes: overview.notes,
          ),
          const SizedBox(height: AppSpacing.section),
          TrainingCommentsList(
            title: overview.commentsTitle,
            comments: overview.comments,
          ),
          const SizedBox(height: AppSpacing.section),
        ],
      ),
    );
  }
}
