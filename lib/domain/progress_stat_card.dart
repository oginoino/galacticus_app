class ProgressStatCard {
  const ProgressStatCard({
    required this.title,
    required this.value,
    required this.delta,
    this.subtitle,
    this.highlighted = false,
  });

  final String title;
  final String value;
  final String delta;
  final String? subtitle;
  final bool highlighted;
}
