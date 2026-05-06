import 'calendar_event.dart';

class CalendarDay {
  const CalendarDay({
    required this.label,
    required this.isSelected,
    required this.isActive,
    this.imageAsset,
    this.event,
  });

  final String label;
  final bool isSelected;
  final bool isActive;
  final String? imageAsset;
  final CalendarEvent? event;
}
