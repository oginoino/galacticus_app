import 'package:flutter/material.dart';

import '../../../../domain/feed_filter.dart';
import '../../../../domain/feed_overview.dart';
import '../../../../domain/feed_story.dart';
import '../../../theme/app_theme.dart';
import 'feed_assets.dart';

class FeedTopBar extends StatelessWidget {
  const FeedTopBar({
    super.key,
    required this.overview,
    required this.onNotificationTap,
  });

  final FeedOverview overview;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final compact = isFeedCompactWidth(context);

    return Row(
      children: [
        Image.asset(
          overview.headerLogoAsset,
          width: AppSize.feedLogoSize,
          height: AppSize.feedLogoSize,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        _FeedIconButton(
          icon: Icons.notifications_none_rounded,
          showDot: true,
          onTap: onNotificationTap,
        ),
        const SizedBox(width: AppSpacing.xl),
        Container(
          width: compact ? AppSize.feedTopActionButton : AppSize.feedHeaderAvatar,
          height: compact ? AppSize.feedTopActionButton : AppSize.feedHeaderAvatar,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppPalette.primary.withValues(alpha: AppOpacity.strong),
              width: AppStroke.thin,
            ),
            image: DecorationImage(
              image: AssetImage(overview.currentUserAvatarAsset),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class FeedStoriesSection extends StatelessWidget {
  const FeedStoriesSection({
    super.key,
    required this.stories,
  });

  final List<FeedStory> stories;

  @override
  Widget build(BuildContext context) {
    final compact = isFeedCompactWidth(context);

    return SizedBox(
      height: AppSize.feedStoryListHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
        itemBuilder: (context, index) => FeedStoryItem(
          story: stories[index],
          compact: compact,
        ),
      ),
    );
  }
}

class FeedFiltersRow extends StatelessWidget {
  const FeedFiltersRow({
    super.key,
    required this.filters,
    required this.onFilterAction,
  });

  final List<FeedFilter> filters;
  final VoidCallback onFilterAction;

  @override
  Widget build(BuildContext context) {
    final compact = isFeedCompactWidth(context);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xl),
                      child: FeedFilterChip(filter: filter),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xl),
        InkWell(
          onTap: onFilterAction,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            width: compact
                ? AppSize.feedFilterHeightCompact
                : AppSize.feedFilterIconButton,
            height: compact
                ? AppSize.feedFilterHeightCompact
                : AppSize.feedFilterIconButton,
            decoration: BoxDecoration(
              color: AppPalette.surfaceAlt,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppPalette.white.withValues(alpha: AppOpacity.lg),
                width: AppStroke.hairline,
              ),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: AppPalette.textMuted,
              size: AppIconSize.xxl,
            ),
          ),
        ),
      ],
    );
  }
}

class FeedStoryItem extends StatelessWidget {
  const FeedStoryItem({
    super.key,
    required this.story,
    required this.compact,
  });

  final FeedStory story;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ringSize = compact
        ? AppSize.feedStoryRingSizeCompact
        : AppSize.feedStoryRingSize;
    final avatarSize = compact
        ? AppSize.feedStoryAvatarSizeCompact
        : AppSize.feedStoryAvatarSize;

    return SizedBox(
      width: ringSize,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: ringSize,
                height: ringSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorFromHex(story.ringColorHex),
                    width: AppSpacing.xxs,
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: _FeedAvatar(
                  size: avatarSize,
                  avatarAsset: story.avatarAsset,
                  initials: story.initials,
                ),
              ),
              if (story.hasAddBadge)
                Positioned(
                  right: 0,
                  bottom: AppSpacing.xxs,
                  child: Container(
                    width: AppSize.feedStoryAddBadge,
                    height: AppSize.feedStoryAddBadge,
                    decoration: BoxDecoration(
                      color: AppPalette.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppPalette.black,
                        width: AppStroke.thin,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppPalette.black,
                      size: AppIconSize.xxl,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            story.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: compact ? AppFontSize.bodyLg : AppFontSize.titleSm,
                  color: AppPalette.white,
                ),
          ),
        ],
      ),
    );
  }
}

class FeedFilterChip extends StatelessWidget {
  const FeedFilterChip({
    super.key,
    required this.filter,
  });

  final FeedFilter filter;

  @override
  Widget build(BuildContext context) {
    final compact = isFeedCompactWidth(context);

    return Container(
      height: compact
          ? AppSize.feedFilterHeightCompact
          : AppSize.feedFilterHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.giant,
      ),
      decoration: BoxDecoration(
        color: filter.isSelected ? AppPalette.white : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: filter.isSelected
              ? AppPalette.white
              : AppPalette.white.withValues(alpha: AppOpacity.sm),
          width: AppStroke.hairline,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        filter.label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: filter.isSelected ? AppPalette.black : AppPalette.white,
              fontWeight: FontWeight.w600,
              letterSpacing: AppLetterSpacing.tightMd,
              fontSize: compact ? AppFontSize.title : AppFontSize.titleLg,
            ),
      ),
    );
  }
}

class _FeedAvatar extends StatelessWidget {
  const _FeedAvatar({
    required this.size,
    required this.avatarAsset,
    required this.initials,
  });

  final double size;
  final String? avatarAsset;
  final String? initials;

  @override
  Widget build(BuildContext context) {
    if (avatarAsset != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(avatarAsset!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppPalette.black,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials ?? '',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppPalette.white,
              letterSpacing: AppLetterSpacing.tightMd,
            ),
      ),
    );
  }
}

class _FeedIconButton extends StatelessWidget {
  const _FeedIconButton({
    required this.icon,
    required this.onTap,
    this.showDot = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        width: AppSize.feedTopActionButton,
        height: AppSize.feedTopActionButton,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppPalette.glassIcon,
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: AppPalette.textMuted,
              size: AppIconSize.xxl,
            ),
            if (showDot)
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  width: AppSize.statusDot,
                  height: AppSize.statusDot,
                  decoration: const BoxDecoration(
                    color: AppPalette.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
