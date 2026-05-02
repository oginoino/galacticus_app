import 'package:flutter/material.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';

class HomeLeaderboardCard extends StatelessWidget {
  const HomeLeaderboardCard({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlowCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: overview.leaderboard
                .map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: entry.isCurrentUser
                          ? const Color(0xFF31401D)
                          : const Color(0xFF171A1E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(
                            '#${entry.position}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: entry.position == 1
                                      ? const Color(0xFFF7C934)
                                      : entry.position == 2
                                          ? const Color(0xFFA7A7A7)
                                          : const Color(0xFFEA8A00),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            HomePrototypeAssets.leaderboardAvatar(entry.name),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.name.replaceAll(' Você', ''),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                entry.points,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: const Color(0xFFBBBBBB),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (entry.isCurrentUser)
                          Text(
                            'Você',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppPalette.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        else
                          Icon(
                            Icons.emoji_events_outlined,
                            color: entry.position == 1
                                ? const Color(0xFFF7C934)
                                : Colors.transparent,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: 12),
        GlowCard(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overview.weeklyHeadline.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFFB0B0B0),
                      letterSpacing: 1.0,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    overview.weeklyTrainings,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF253413),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      overview.weeklyVariation,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                            color: AppPalette.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const HomeBarChart(),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.totalTime,
                      label: 'Tempo total',
                    ),
                  ),
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.calories,
                      label: 'Calorias',
                    ),
                  ),
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.consistency,
                      label: 'Consistência',
                      highlight: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeCalendarCard extends StatelessWidget {
  const HomeCalendarCard({
    super.key,
    required this.overview,
  });

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
    final cells = List<HomeCalendarCell?>.filled(4, null, growable: true)
      ..addAll(
        overview.calendarDays.map(
          (day) => HomeCalendarCell(
            label: day.label,
            isSelected: day.isSelected,
            imageAsset: HomePrototypeAssets.calendarImage(
              day.label,
              day.isActive,
            ),
          ),
        ),
      );

    return GlowCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        children: [
          Row(
            children: [
              const HomeNavCircle(icon: Icons.chevron_left_rounded),
              const Spacer(),
              Text(
                overview.calendarMonthLabel[0].toUpperCase() +
                    overview.calendarMonthLabel.substring(1),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              const HomeNavCircle(icon: Icons.chevron_right_rounded),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: weekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: const Color(0xFF696F76),
                            ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final cell = cells[index];
              if (cell == null) {
                return const SizedBox.shrink();
              }

              if (cell.isSelected) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cell.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                );
              }

              if (cell.imageAsset != null) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(cell.imageAsset!),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cell.label,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Text(
                  cell.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF7D838B),
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomeBarChart extends StatelessWidget {
  const HomeBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    const heights = [28.0, 42.0, 20.0, 52.0, 36.0, 58.0, 46.0];
    const labels = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

    return Column(
      children: [
        SizedBox(
          height: 72,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              heights.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    height: heights[index],
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B8D3B),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: labels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF82888F),
                          ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}

class HomeMiniBarChart extends StatelessWidget {
  const HomeMiniBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    const heights = [18.0, 26.0, 14.0, 24.0, 20.0, 28.0, 24.0];

    return SizedBox(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          heights.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: heights[index],
                color: index.isEven
                    ? const Color(0xFF6C8F3D)
                    : const Color(0xFF89B84A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeStatMetric extends StatelessWidget {
  const HomeStatMetric({
    super.key,
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: highlight ? AppPalette.primary : Colors.white,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFB1B1B1),
              ),
        ),
      ],
    );
  }
}

class HomeNavCircle extends StatelessWidget {
  const HomeNavCircle({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1A1D21),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.04),
        ),
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF9BA1A7)),
    );
  }
}

class HomeCalendarCell {
  const HomeCalendarCell({
    required this.label,
    required this.isSelected,
    required this.imageAsset,
  });

  final String label;
  final bool isSelected;
  final String? imageAsset;
}

class HomeSportChip extends StatelessWidget {
  const HomeSportChip({
    super.key,
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlighted
            ? const Color(0xFF233913)
            : const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted
              ? AppPalette.primary
              : const Color(0xFFCECECE),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
