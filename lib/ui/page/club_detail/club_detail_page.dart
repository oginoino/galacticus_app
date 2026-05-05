import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/club_detail_overview.dart';
import '../../../provider/club_detail_provider.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/club_detail_widgets.dart';

class ClubDetailPage extends StatefulWidget {
  const ClubDetailPage({super.key, required this.slug});

  final String slug;

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClubDetailProvider>().loadClub(slug: widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClubDetailProvider>();
    final overview = provider.overview;

    return AppSliverScaffold(
      title: overview?.name ?? '',
      subtitle: overview?.headline,
      slivers: [
        SliverToBoxAdapter(
          child: ContentStateView(
            isLoading: provider.isLoading && overview == null,
            errorMessage: provider.errorMessage != null && overview == null
                ? provider.errorMessage
                : null,
            onRetry: () => provider.loadClub(slug: widget.slug),
            retryLabel: sl<AppConstants>().retryLabel,
            child: overview == null
                ? const SizedBox.shrink()
                : _buildContent(context, overview),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, ClubDetailOverview overview) {
    return Padding(
      padding: AppInsets.pageHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          ClubHero(
            imageAsset: overview.heroImageAsset,
            membersLabel: overview.membersLabel,
            privacyLabel: overview.privacyLabel,
            headline: overview.headline,
          ),
          const SizedBox(height: AppSpacing.section),
          ClubActions(
            joinLabel: overview.joinLabel,
            shareLabel: overview.shareLabel,
            onJoin: () {},
            onShare: () {},
          ),
          const SizedBox(height: AppSpacing.section),
          ClubTagRow(tags: overview.tags),
          const SizedBox(height: AppSpacing.section),
          Text(
            overview.descriptionTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.titleLg,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            overview.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textSecondary,
                  fontSize: AppFontSize.bodyLg,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: AppSpacing.section),
          ClubMembersStrip(
            title: overview.membersTitle,
            members: overview.members,
          ),
          const SizedBox(height: AppSpacing.section),
          ClubSessionsList(
            title: overview.sessionsTitle,
            sessions: overview.sessions,
          ),
          const SizedBox(height: AppSpacing.section),
          ClubPhotoGrid(
            title: overview.photosTitle,
            photos: overview.photos,
          ),
          const SizedBox(height: AppSpacing.section),
          ClubRulesList(
            title: overview.rulesTitle,
            rules: overview.rules,
          ),
          const SizedBox(height: AppSpacing.section),
        ],
      ),
    );
  }
}
