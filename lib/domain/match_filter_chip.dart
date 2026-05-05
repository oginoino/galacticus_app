class MatchFilterChip {
  const MatchFilterChip({
    required this.label,
    required this.value,
    this.isSelected = false,
  });

  final String label;
  final String value;
  final bool isSelected;
}
