import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/dashboard_overview.dart';
import '../../../../route/routes/routes.dart';
import '../../../components/glow_card.dart';
import '../../../theme/app_theme.dart';

class HomeLeaderboardCard extends StatelessWidget {
  const HomeLeaderboardCard({super.key, required this.overview});

  final DashboardOverview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlowCard(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            children: overview.leaderboard
                .map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                      vertical: AppSpacing.xl,
                    ),
                    decoration: BoxDecoration(
                      color: entry.isCurrentUser
                          ? AppPalette.successHighlight
                          : AppPalette.glassBorder,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppIconSize.giant,
                          child: Text(
                            '${overview.uiLabels.leaderboardPositionPrefix}${entry.position}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: entry.position == 1
                                      ? AppPalette.gold
                                      : entry.position == 2
                                      ? AppPalette.silver
                                      : AppPalette.bronze,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        CircleAvatar(
                          radius: AppSize.leaderboardAvatarRadius,
                          backgroundImage: AssetImage(entry.avatarAsset),
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.name,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                entry.points,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppPalette.textSoft),
                              ),
                            ],
                          ),
                        ),
                        if (entry.isCurrentUser)
                          Text(
                            overview.uiLabels.leaderboardCurrentUserLabel,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppPalette.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        else
                          Icon(
                            Icons.emoji_events_outlined,
                            color: entry.position == 1
                                ? AppPalette.gold
                                : Colors.transparent,
                            size: AppIconSize.lg,
                          ),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        GlowCard(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.huge,
            AppSpacing.huge,
            AppSpacing.huge,
            AppSpacing.xxxl,
          ),
          onTap: () => context.push(Routes.progress),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overview.weeklyHeadline.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppPalette.textStats,
                  letterSpacing: AppLetterSpacing.wideSm,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
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
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.successSoft,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Text(
                      overview.weeklyVariation,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppPalette.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.huge),
              HomeBarChart(labels: overview.chartWeekdays),
              const SizedBox(height: AppSpacing.huge),
              Row(
                children: [
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.totalTime,
                      label: overview.uiLabels.weeklyTimeLabel,
                    ),
                  ),
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.calories,
                      label: overview.uiLabels.weeklyCaloriesLabel,
                    ),
                  ),
                  Expanded(
                    child: HomeStatMetric(
                      value: overview.consistency,
                      label: overview.uiLabels.weeklyConsistencyLabel,
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

class HomeCalendarCard extends StatefulWidget {
  const HomeCalendarCard({super.key, required this.overview});

  final DashboardOverview overview;

  @override
  State<HomeCalendarCard> createState() => _HomeCalendarCardState();
}

class _HomeCalendarCardState extends State<HomeCalendarCard> {
  late final DateTime _baseMonth;
  late DateTime _displayedMonth;
  late DateTime _selectedDate;
  late final Map<DateTime, _HomeCalendarEvent> _eventsByDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final month = _monthNumberFromLabel(widget.overview.calendarMonthLabel);
    _baseMonth = DateTime(now.year, month, 1);
    _displayedMonth = _baseMonth;

    final selectedDay = widget.overview.calendarDays.firstWhere(
      (day) => day.isSelected,
      orElse: () => widget.overview.calendarDays.first,
    );
    _selectedDate = DateTime(
      _baseMonth.year,
      _baseMonth.month,
      int.tryParse(selectedDay.label) ?? 1,
    );

    _eventsByDate = {
      for (final day in widget.overview.calendarDays)
        if (day.isActive)
          DateTime(
            _baseMonth.year,
            _baseMonth.month,
            int.tryParse(day.label) ?? 1,
          ): _HomeCalendarEvent(
            imageAsset: day.imageAsset,
            hasMarker: true,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final monthCells = _buildCalendarCells(_displayedMonth);

    return GlowCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xxl,
        AppSpacing.xxl,
        AppSpacing.xxxl,
      ),
      child: Column(
        children: [
          Row(
            children: [
              HomeNavCircle(
                icon: Icons.chevron_left_rounded,
                onTap: () => _changeMonth(-1),
              ),
              const Spacer(),
              Text(
                _monthLabel(_displayedMonth),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              HomeNavCircle(
                icon: Icons.chevron_right_rounded,
                onTap: () => _changeMonth(1),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            children: widget.overview.calendarWeekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppPalette.textCalendar,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: monthCells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
            ),
            itemBuilder: (context, index) {
              final cell = monthCells[index];
              if (!cell.isCurrentMonth) {
                return const SizedBox.shrink();
              }

              if (cell.isSelected) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(AppRadius.xxxl),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cell.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppPalette.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              }

              if (cell.event?.imageAsset != null) {
                return GestureDetector(
                  onTap: () => _selectDate(cell.date),
                  child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(cell.event!.imageAsset!),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: AppPalette.white.withValues(
                              alpha: AppOpacity.lg,
                            ),
                            width: AppStroke.hairline,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cell.label,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Container(
                      width: AppSize.ringSmall,
                      height: AppSize.ringSmall,
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                  ),
                );
              }

              return GestureDetector(
                onTap: () => _selectDate(cell.date),
                child: Center(
                  child: Text(
                    cell.label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(
                      color: cell.event?.hasMarker == true
                          ? AppPalette.white
                          : AppPalette.textDim,
                      fontWeight: cell.event?.hasMarker == true
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + delta, 1);
      final daysInMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
        0,
      ).day;
      final nextDay = _selectedDate.day > daysInMonth ? daysInMonth : _selectedDate.day;
      _selectedDate = DateTime(_displayedMonth.year, _displayedMonth.month, nextDay);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  List<_HomeCalendarGridCell> _buildCalendarCells(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final leadingEmpty = firstDay.weekday % 7;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final totalCells = ((leadingEmpty + daysInMonth) / 7).ceil() * 7;

    return List.generate(totalCells, (index) {
      if (index < leadingEmpty || index >= leadingEmpty + daysInMonth) {
        return _HomeCalendarGridCell.empty();
      }

      final day = index - leadingEmpty + 1;
      final date = DateTime(month.year, month.month, day);
      final event = _eventsByDate[date];

      return _HomeCalendarGridCell(
        date: date,
        label: '$day',
        isCurrentMonth: true,
        isSelected: _isSameDate(date, _selectedDate),
        event: event,
      );
    });
  }
}

class HomeBarChart extends StatelessWidget {
  const HomeBarChart({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSize.chartHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              AppChartHeights.weekly.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    height: AppChartHeights.weekly[index],
                    decoration: BoxDecoration(
                      color: AppPalette.chartBarA,
                      borderRadius: BorderRadius.circular(
                        AppSize.chartBarWidthRadius,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: labels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.textAxis,
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
    return SizedBox(
      height: AppSize.miniChartHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          AppChartHeights.mini.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: AppChartHeights.mini[index],
                color: index.isEven
                    ? AppPalette.chartBarB
                    : AppPalette.chartBarC,
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
            color: highlight ? AppPalette.primary : AppPalette.white,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppPalette.textStats),
        ),
      ],
    );
  }
}

class HomeNavCircle extends StatelessWidget {
  const HomeNavCircle({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        width: AppSize.navCircle,
        height: AppSize.navCircle,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppPalette.calendarDark,
          border: Border.all(
            color: AppPalette.white.withValues(alpha: AppOpacity.xs),
          ),
        ),
        child: Icon(icon, size: AppIconSize.lg, color: AppPalette.iconSubtle),
      ),
    );
  }
}

class _HomeCalendarGridCell {
  const _HomeCalendarGridCell({
    required this.date,
    required this.label,
    required this.isCurrentMonth,
    required this.isSelected,
    this.event,
  });

  factory _HomeCalendarGridCell.empty() {
    return _HomeCalendarGridCell(
      date: DateTime(1970),
      label: '',
      isCurrentMonth: false,
      isSelected: false,
    );
  }

  final DateTime date;
  final String label;
  final bool isCurrentMonth;
  final bool isSelected;
  final _HomeCalendarEvent? event;
}

class _HomeCalendarEvent {
  const _HomeCalendarEvent({
    this.imageAsset,
    required this.hasMarker,
  });

  final String? imageAsset;
  final bool hasMarker;
}

int _monthNumberFromLabel(String label) {
  switch (label.trim().toLowerCase()) {
    case 'janeiro':
      return 1;
    case 'fevereiro':
      return 2;
    case 'março':
    case 'marco':
      return 3;
    case 'abril':
      return 4;
    case 'maio':
      return 5;
    case 'junho':
      return 6;
    case 'julho':
      return 7;
    case 'agosto':
      return 8;
    case 'setembro':
      return 9;
    case 'outubro':
      return 10;
    case 'novembro':
      return 11;
    case 'dezembro':
      return 12;
    default:
      return DateTime.now().month;
  }
}

String _monthLabel(DateTime date) {
  const monthLabels = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  return monthLabels[date.month - 1];
}

bool _isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: highlighted ? AppPalette.successDark : AppPalette.chipInactive,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppPalette.primary : AppPalette.textGlass,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
