import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../domain/assistant_overview.dart';
import '../../../../domain/assistant_prompt_option.dart';
import '../../../theme/app_theme.dart';

class AssistantHeader extends StatelessWidget {
  const AssistantHeader({
    super.key,
    required this.onlineLabel,
    required this.onBackTap,
  });

  final String onlineLabel;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: EdgeInsets.only(top: topInset + AppSpacing.lg),
      child: Row(
        children: [
          InkWell(
            onTap: onBackTap,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              width: AppSize.assistantTopAction,
              height: AppSize.assistantTopAction,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                  width: AppStroke.hairline,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppPalette.white,
                size: AppIconSize.huge,
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: AppSize.assistantStatusHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.giant,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                width: AppStroke.hairline,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: AppSpacing.sm,
                  height: AppSpacing.sm,
                  decoration: const BoxDecoration(
                    color: AppPalette.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  onlineLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontWeight: FontWeight.w500,
                        fontSize: AppFontSize.labelLg,
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

class AssistantHero extends StatelessWidget {
  const AssistantHero({
    super.key,
    required this.overview,
  });

  final AssistantOverview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: AppSize.assistantHeroLogo,
          height: AppSize.assistantHeroLogo,
          child: Image.asset(
            overview.logoAsset,
            fit: BoxFit.contain,
          )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .scale(
                begin: const Offset(
                  AppMotion.assistantLogoPulseMinScale,
                  AppMotion.assistantLogoPulseMinScale,
                ),
                end: const Offset(
                  AppMotion.assistantLogoPulseMaxScale,
                  AppMotion.assistantLogoPulseMaxScale,
                ),
                duration: AppMotion.assistantLogoPulseDurationMs.ms,
                curve: Curves.linear,
              )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .rotate(
                begin: 0,
                end: 1,
                duration: AppMotion.assistantLogoRotateDurationMs.ms,
                curve: Curves.linear,
              ),
        ),
        const SizedBox(height: AppSpacing.page),
        Text(
          overview.greeting,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.displaySm,
                letterSpacing: AppLetterSpacing.tightSm,
              ),
        ),
        const SizedBox(height: AppSpacing.xl),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.headingSm,
                  height: 1.4,
                ),
            children: [
              TextSpan(text: overview.subtitlePrefix),
              TextSpan(
                text: overview.highlightText,
                style: const TextStyle(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: overview.subtitleSuffix),
            ],
          ),
        ),
      ],
    );
  }
}

class AssistantPromptList extends StatelessWidget {
  const AssistantPromptList({
    super.key,
    required this.items,
    required this.logoAsset,
    required this.onTap,
  });

  final List<AssistantPromptOption> items;
  final String logoAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(
                bottom: item == items.last ? 0 : AppSpacing.xl,
              ),
              child: AssistantPromptCard(
                item: item,
                logoAsset: logoAsset,
                onTap: onTap,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class AssistantPromptCard extends StatelessWidget {
  const AssistantPromptCard({
    super.key,
    required this.item,
    required this.logoAsset,
    required this.onTap,
  });

  final AssistantPromptOption item;
  final String logoAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        height: AppSize.assistantPromptHeight,
        padding: AppInsets.assistantPrompt,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              logoAsset,
              width: AppIconSize.giantPlus,
              height: AppIconSize.giantPlus,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: AppSpacing.giant),
            Expanded(
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppPalette.white,
                      fontSize: AppFontSize.titleSm,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssistantComposer extends StatelessWidget {
  const AssistantComposer({
    super.key,
    required this.placeholder,
    required this.onSendTap,
  });

  final String placeholder;
  final VoidCallback onSendTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.page,
        AppSpacing.page,
        bottomInset + AppSpacing.page,
      ),
      child: Container(
        height: AppSize.assistantInputHeight,
        padding: AppInsets.assistantInput,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppPalette.assistantStart.withValues(alpha: AppOpacity.heavy),
              AppPalette.surfaceAlt.withValues(alpha: AppOpacity.heavy),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                placeholder,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppPalette.textMuted,
                      fontSize: AppFontSize.title,
                    ),
              ),
            ),
            const SizedBox(width: AppSpacing.giant),
            InkWell(
              onTap: onSendTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: AppSize.assistantSendButton,
                height: AppSize.assistantSendButton,
                decoration: const BoxDecoration(
                  color: AppPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.near_me_outlined,
                  color: AppPalette.black,
                  size: AppIconSize.xxl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
