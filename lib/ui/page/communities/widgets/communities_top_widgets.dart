import 'package:flutter/material.dart';

import '../../../../domain/communities_overview.dart';
import '../../../theme/app_theme.dart';

class CommunitiesHeader extends StatelessWidget {
  const CommunitiesHeader({
    super.key,
    required this.overview,
  });

  final CommunitiesOverview overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            overview.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.displaySm,
                  letterSpacing: AppLetterSpacing.tightMd,
                ),
          ),
        ),
        _CommunitiesTopIconButton(
          icon: Icons.notifications_none_rounded,
        ),
        const SizedBox(width: AppSpacing.xl),
        Container(
          width: AppSize.communitiesHeaderAvatar,
          height: AppSize.communitiesHeaderAvatar,
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

class CommunitiesSearchBar extends StatelessWidget {
  const CommunitiesSearchBar({
    super.key,
    required this.placeholder,
    required this.onTap,
  });

  final String placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        height: AppSize.communitiesSearchHeight,
        padding: AppInsets.communitiesSearch,
        decoration: BoxDecoration(
          color: AppPalette.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: AppPalette.textDim,
              size: AppIconSize.xxl,
            ),
            const SizedBox(width: AppSpacing.xl),
            Text(
              placeholder,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textDim,
                    fontSize: AppFontSize.titleSm,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunitiesSectionHeader extends StatelessWidget {
  const CommunitiesSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              actionLabel!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textMuted,
                    fontSize: AppFontSize.titleSm,
                  ),
            ),
          ),
      ],
    );
  }
}

class CommunitiesCategoryChips extends StatelessWidget {
  const CommunitiesCategoryChips({
    super.key,
    required this.overview,
    required this.onFilterTap,
  });

  final CommunitiesOverview overview;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.communitiesChipHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: overview.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
        itemBuilder: (context, index) {
          final category = overview.categories[index];

          return InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.page,
              ),
              decoration: BoxDecoration(
                color: category.isSelected ? AppPalette.white : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: category.isSelected
                      ? AppPalette.white
                      : AppPalette.white.withValues(alpha: AppOpacity.xl),
                  width: AppStroke.hairline,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                category.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          category.isSelected ? AppPalette.black : AppPalette.white,
                      fontWeight: FontWeight.w500,
                      fontSize: AppFontSize.titleSm,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CommunitiesTopIconButton extends StatelessWidget {
  const _CommunitiesTopIconButton({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.communitiesTopIcon,
      height: AppSize.communitiesTopIcon,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.glassIcon,
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Icon(
        icon,
        color: AppPalette.textMuted,
        size: AppIconSize.xxl,
      ),
    );
  }
}
