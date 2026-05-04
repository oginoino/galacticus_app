import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../domain/ai_training_metric.dart';
import '../../../../domain/ai_training_reference.dart';
import '../../../theme/app_theme.dart';

class AiTrainingHeader extends StatelessWidget {
  const AiTrainingHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.closeSemantics,
    required this.onCloseTap,
  });

  final String eyebrow;
  final String title;
  final String closeSemantics;
  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: AppResponsiveInsets.overlayTopBar(topInset),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppPalette.primary,
                      size: AppIconSize.md,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      eyebrow,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppPalette.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.labelLg,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppFontSize.heading,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.page),
          Semantics(
            label: closeSemantics,
            button: true,
            child: InkWell(
              onTap: onCloseTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: AppSize.aiTrainingTopAction,
                height: AppSize.aiTrainingTopAction,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppPalette.white,
                  size: AppIconSize.huge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AiTrainingProgressCard extends StatelessWidget {
  const AiTrainingProgressCard({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
    required this.subtitle,
  });

  final int currentStep;
  final int totalSteps;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.aiTrainingProgressWidth,
      padding: AppInsets.actionChipPadding,
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: List.generate(totalSteps, (index) {
                return Expanded(
                  child: Container(
                    height: 6,
                    margin: EdgeInsets.only(
                      right: index == totalSteps - 1 ? 0 : AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: index < currentStep
                          ? AppPalette.primary
                          : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title $currentStep/$totalSteps',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: AppFontSize.labelLg,
                      ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.white,
                        fontSize: AppFontSize.bodySm,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AiTrainingModeSelector extends StatelessWidget {
  const AiTrainingModeSelector({
    super.key,
    required this.modes,
    required this.selectedMode,
    required this.onTap,
  });

  final List<String> modes;
  final String selectedMode;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: modes
          .map(
            (mode) => InkWell(
              onTap: () => onTap(mode),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: AppInsets.actionChipPadding,
                decoration: BoxDecoration(
                  color: selectedMode == mode
                      ? AppPalette.primary
                      : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  mode,
                  style: TextStyle(
                    color: selectedMode == mode ? AppPalette.black : AppPalette.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.bodySm,
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class AiTrainingReferenceList extends StatelessWidget {
  const AiTrainingReferenceList({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<AiTrainingReference> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.aiTrainingReferenceCardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final item = items[index];
          final selected = index == selectedIndex;

          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Container(
              width: AppSize.aiTrainingReferenceCardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: selected
                      ? AppPalette.primary
                      : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                  width: AppStroke.hairline,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(item.imageAsset, fit: BoxFit.cover),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppPalette.black.withValues(alpha: AppOpacity.lg),
                            AppPalette.black.withValues(alpha: AppOpacity.overlay),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppInsets.pillPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppFontSize.body,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            item.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppPalette.textMuted,
                                  fontSize: AppFontSize.labelLg,
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
        },
      ),
    );
  }
}

class AiTrainingAssistantPopup extends StatelessWidget {
  const AiTrainingAssistantPopup({
    super.key,
    required this.logoAsset,
    required this.title,
    required this.child,
  });

  final String logoAsset;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.cardPaddingLg,
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
        boxShadow: [
          BoxShadow(
            color: AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
            blurRadius: AppShadow.cardBlur,
            offset: const Offset(0, AppShadow.cardOffsetY),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppPalette.primary.withValues(alpha: AppOpacity.xs),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                padding: AppInsets.pillPaddingCompact,
                child: Image.asset(
                  logoAsset,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.labelLg,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          child,
        ],
      ),
    );
  }
}

class AiTrainingInstructionCard extends StatelessWidget {
  const AiTrainingInstructionCard({
    super.key,
    required this.body,
    required this.metrics,
    required this.buttonLabel,
    required this.onTap,
  });

  final String body;
  final List<AiTrainingMetric> metrics;
  final String buttonLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          body,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppPalette.white,
                fontSize: AppFontSize.body,
                height: 1.55,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: metrics
              .map(
                (metric) => _AiTrainingTag(
                  label: metric.label,
                  highlighted: false,
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: AppPalette.primary,
              foregroundColor: AppPalette.black,
              minimumSize: const Size(0, AppSize.buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
            icon: const Icon(
              Icons.play_arrow_rounded,
              size: AppIconSize.xxl,
            ),
            label: Text(
              buttonLabel,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.body,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AiTrainingInsetMediaCard extends StatelessWidget {
  const AiTrainingInsetMediaCard({
    super.key,
    required this.badgeLabel,
    required this.statusLabel,
    required this.media,
    required this.onTap,
    this.highlighted = false,
    this.pulsing = false,
  });

  final String badgeLabel;
  final String statusLabel;
  final Widget media;
  final VoidCallback onTap;
  final bool highlighted;
  final bool pulsing;

  @override
  Widget build(BuildContext context) {
    final card = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: AppSize.aiTrainingPreviewWidth,
        height: AppSize.aiTrainingPreviewHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: highlighted ? AppPalette.primary : AppPalette.white,
            width: AppStroke.hairline,
          ),
          boxShadow: [
            BoxShadow(
              color: (highlighted ? AppPalette.primary : AppPalette.black)
                  .withValues(alpha: AppOpacity.sm),
              blurRadius: AppShadow.cardBlur,
              offset: const Offset(0, AppShadow.cardOffsetY),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            fit: StackFit.expand,
            children: [
              media,
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.none),
                      AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: AppSpacing.xs,
                left: AppSpacing.xs,
                child: _AiTrainingTag(
                  label: badgeLabel,
                  highlighted: highlighted,
                ),
              ),
              Positioned(
                left: AppSpacing.xs,
                right: AppSpacing.xs,
                bottom: AppSpacing.xs,
                child: Text(
                  statusLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.white,
                        fontSize: AppFontSize.labelLg,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!pulsing) {
      return card;
    }

    return card
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: const Offset(0.98, 0.98),
          end: const Offset(1.01, 1.01),
          duration: AppMotion.aiTrainingPreviewPulseDurationMs.ms,
          curve: Curves.linear,
        );
  }
}

class _AiTrainingTag extends StatelessWidget {
  const _AiTrainingTag({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.pillPadding,
      decoration: BoxDecoration(
        color: highlighted
            ? AppPalette.primary
            : AppPalette.white.withValues(alpha: AppOpacity.xxs),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppPalette.black : AppPalette.white,
          fontWeight: FontWeight.w700,
          fontSize: AppFontSize.labelLg,
        ),
      ),
    );
  }
}
