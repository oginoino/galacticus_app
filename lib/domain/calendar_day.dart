class CalendarDay {
  const CalendarDay({
    required this.label,
    required this.isSelected,
    required this.isActive,
    this.imageAsset,
  });

  final String label;
  final bool isSelected;
  final bool isActive;
  final String? imageAsset;
}
