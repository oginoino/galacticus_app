class ProgressActivityRingMetric {
  const ProgressActivityRingMetric({
    required this.title,
    required this.value,
    required this.targetLabel,
    required this.progress,
    required this.colorHex,
  });

  final String title;
  final String value;
  final String targetLabel;
  final double progress;
  final String colorHex;
}
