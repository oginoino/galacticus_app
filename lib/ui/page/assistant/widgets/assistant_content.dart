import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../domain/assistant_overview.dart';
import '../../../theme/app_theme.dart';
import 'assistant_widgets.dart';

class AssistantContent extends StatelessWidget {
  const AssistantContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onPromptTap,
    required this.onSendTap,
  });

  final AssistantOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onPromptTap;
  final VoidCallback onSendTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: Container(
                width: 220,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.primary.withValues(alpha: AppOpacity.none),
                      AppPalette.primary.withValues(alpha: AppOpacity.xxs),
                      AppPalette.primary.withValues(alpha: AppOpacity.sm),
                      AppPalette.primary.withValues(alpha: AppOpacity.none),
                    ],
                  ),
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .fade(
                    begin: 0.55,
                    end: 0.9,
                    duration: AppMotion.assistantScreenGlowDurationMs.ms,
                    curve: Curves.linear,
                  ),
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            children: [
              AssistantHeader(
                onlineLabel: overview.onlineLabel,
                onBackTap: onBackTap,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.page,
                    0,
                    AppSpacing.page,
                    AppSpacing.page,
                  ),
                  children: [
                    const SizedBox(height: 76),
                    AssistantHero(overview: overview),
                    const SizedBox(height: 44),
                    AssistantPromptList(
                      items: overview.promptOptions,
                      logoAsset: overview.logoAsset,
                      onTap: onPromptTap,
                    ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AssistantComposer(
            placeholder: overview.inputPlaceholder,
            onSendTap: onSendTap,
          ),
        ),
      ],
    );
  }
}
