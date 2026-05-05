class TrainingMetric {
  const TrainingMetric({
    required this.label,
    required this.value,
    this.delta,
    this.trend,
  });

  final String label;
  final String value;
  final String? delta;
  final String? trend; // 'up' | 'down' | 'flat'
}
