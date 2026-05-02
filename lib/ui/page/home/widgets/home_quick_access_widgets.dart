import 'package:flutter/material.dart';

import '../../../../domain/quick_access_item.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';
import 'home_dashboard_widgets.dart';

class HomeQuickAccessCard extends StatelessWidget {
  const HomeQuickAccessCard({
    super.key,
    required this.item,
  });

  final QuickAccessItem item;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      height: compact
          ? AppSize.quickAccessCardHeightCompact
          : AppSize.quickAccessCardHeight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.sm),
            width: AppStroke.hairline,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                HomePrototypeAssets.quickAccessBackground(item.icon),
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.stronger),
                      AppPalette.black.withValues(alpha: AppOpacity.overlay),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? AppSpacing.xl : AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: AppLetterSpacing.tightXl,
                            fontSize: compact
                                ? AppFontSize.title
                                : AppFontSize.headingSm,
                          ),
                    ),
                    SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _content(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    switch (item.icon) {
      case 'check':
        return [
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final active in [true, false, true, true, false, true, false])
                Container(
                  width: AppSpacing.giant,
                  height: AppSpacing.giant,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppPalette.primary
                        : AppPalette.inactiveDot,
                  ),
                  child: active
                      ? const Icon(
                          Icons.check,
                          size: AppFontSize.body,
                          color: AppPalette.black,
                        )
                      : null,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: ['S', 'T', 'Q', 'Q', 'S', 'S', 'D']
                .map(
                  (label) => Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppPalette.textHint,
                            fontSize: AppFontSize.caption,
                          ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textGlass,
                  fontSize: AppFontSize.body,
                ),
          ),
        ];
      case 'event':
        return [
          Text(
            item.accentLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textNeutral,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Torneio de Duplas',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: AppSpacing.sm,
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              const Text(
                '14/20',
                style: TextStyle(color: AppPalette.textNeutralAlt),
              ),
            ],
          ),
        ];
      case 'sports':
        return [
          Text(
            'Última partida',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textNeutralAlt,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Você    Rafael',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textNeutralAlt,
                  fontSize: AppFontSize.body,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '6 × 4',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: AppFontSize.metric,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppPalette.successDark,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              'Vitória',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ];
      case 'chart':
        return [
          const HomeMiniBarChart(),
          const SizedBox(height: AppSpacing.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '85%',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppPalette.white,
                      fontSize: AppFontSize.metric,
                    ),
              ),
              Text(
                'consistência',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppPalette.textGlass,
                    ),
              ),
            ],
          ),
        ];
      case 'ranking':
        return [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '#12',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFontSize.displaySm,
                    ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sua posição',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppPalette.textGlass,
                            ),
                      ),
                      Text(
                        '↑ 3 posições',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPalette.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ];
      case 'shooting':
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'novas fotos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPalette.textGlass,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...HomePrototypeAssets.quickAccessAvatars.map(
                (asset) => CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                width: AppSize.badgeSquare,
                height: AppSize.badgeSquare,
                decoration: BoxDecoration(
                  color: AppPalette.white.withValues(alpha: AppOpacity.soft),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: AppPalette.white.withValues(alpha: AppOpacity.medium),
                    width: AppStroke.hairline,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'clubs':
        return [
          Text(
            '3 clubes ativos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textGlass,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...HomePrototypeAssets.clubAvatars.map(
                (asset) => CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxl),
                  borderRadius: BorderRadius.circular(AppSpacing.xxxl),
                ),
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'calendar':
        return [
          Text(
            'Quadra 03 disponível',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.textCalendarLight,
                  fontSize: AppFontSize.titleSm,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Hoje · 18:00–19:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.headingSm,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              HomeSportChip(label: 'Tennis', highlighted: true),
              HomeSportChip(label: 'Padel'),
            ],
          ),
        ];
      default:
        return [
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textGlass,
                ),
          ),
        ];
    }
  }
}
