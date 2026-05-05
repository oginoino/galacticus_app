class ShotItem {
  const ShotItem({
    required this.id,
    required this.dateLabel,
    required this.sportIcon,
    required this.sportLabel,
    required this.courtLabel,
    required this.imageAsset,
    this.durationLabel,
  });

  final String id;
  final String dateLabel;
  final String sportIcon;
  final String sportLabel;
  final String courtLabel;
  final String imageAsset;
  final String? durationLabel;
}
