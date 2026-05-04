import 'package:flutter/material.dart';

import '../../../../domain/agenda_overview.dart';
import '../../../theme/app_theme.dart';
import 'agenda_widgets.dart';

class AgendaContent extends StatelessWidget {
  const AgendaContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onEventTap,
    required this.onMatchTap,
  });

  final AgendaOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onEventTap;
  final VoidCallback onMatchTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AgendaHeader(
          title: overview.title,
          onBackTap: onBackTap,
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: AppInsets.agendaPage,
            children: [
              AgendaSectionTitle(title: overview.eventsTitle),
              const SizedBox(height: AppSpacing.xl),
              AgendaEventsList(
                items: overview.events,
                onTap: onEventTap,
              ),
              const SizedBox(height: AppSpacing.sectionLg),
              AgendaSectionTitle(title: overview.matchesTitle),
              const SizedBox(height: AppSpacing.xl),
              AgendaMatchesList(
                items: overview.matches,
                onTap: onMatchTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
