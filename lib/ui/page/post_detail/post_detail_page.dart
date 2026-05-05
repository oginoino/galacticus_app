import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/post_detail_overview.dart';
import '../../../provider/post_detail_provider.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/post_detail_widgets.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostDetailProvider>();
    final overview = provider.overview;

    return AppSliverScaffold(
      title: overview?.headerTitle ?? '',
      subtitle: overview?.headerSubtitle,
      trailing: overview != null ? PostBadgeChip(badge: overview.badge) : null,
      slivers: [
        SliverToBoxAdapter(
          child: ContentStateView(
            isLoading: provider.isLoading && overview == null,
            errorMessage: provider.errorMessage != null && overview == null
                ? provider.errorMessage
                : null,
            onRetry: provider.loadPost,
            retryLabel: sl<AppConstants>().retryLabel,
            child: overview == null
                ? const SizedBox.shrink()
                : _buildContent(context, overview),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, PostDetailOverview overview) {
    return Padding(
      padding: AppInsets.pageHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          PostAuthorRow(author: overview.author),
          const SizedBox(height: AppSpacing.section),
          Text(
            overview.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            overview.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textSecondary,
                  fontSize: AppFontSize.bodyLg,
                  height: 1.4,
                ),
          ),
          if (overview.tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: overview.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.surfaceAlt,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: AppPalette.white
                              .withValues(alpha: AppOpacity.xxs),
                          width: AppStroke.hairline,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppPalette.textSecondary,
                              fontSize: AppFontSize.bodySm,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
          if (overview.mediaImageAsset != null) ...[
            const SizedBox(height: AppSpacing.section),
            PostMediaCard(
              imageAsset: overview.mediaImageAsset!,
              checkinOverlay: overview.checkinOverlay,
            ),
          ],
          const SizedBox(height: AppSpacing.section),
          PostCountersRow(counters: overview.counters),
          const SizedBox(height: AppSpacing.section),
          PostCommentsList(
            title: overview.commentsTitle,
            comments: overview.comments,
          ),
          const SizedBox(height: AppSpacing.section),
          PostReplyComposer(placeholder: overview.replyPlaceholder),
          const SizedBox(height: AppSpacing.section),
        ],
      ),
    );
  }
}
