class TrainingHero {
  const TrainingHero({
    required this.iconKey,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.tertiaryLabel,
  });

  /// Icon key consumed by the UI (e.g., 'tennis', 'padel', 'run').
  final String iconKey;
  final String primaryLabel;
  final String secondaryLabel;
  final String tertiaryLabel;
}
