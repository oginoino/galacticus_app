class CheckinOverlay {
  const CheckinOverlay({
    required this.type,
    this.headline,
    this.subheadline,
    this.sportLabel,
    this.locationLabel,
    this.weatherLabel,
    this.timeLabel,
    this.metrics = const [],
    this.scoreHome,
    this.scoreAway,
    this.teamHome,
    this.teamAway,
    this.achievementLabel,
  });

  /// Filter icon key. Matches CheckinFilterOption.icon and post overlay type.
  /// Examples: bar_chart, location, schedule, trophy, score, session, pulse,
  /// minimal, favorite. The `block` key means no overlay.
  final String type;
  final String? headline;
  final String? subheadline;
  final String? sportLabel;
  final String? locationLabel;
  final String? weatherLabel;
  final String? timeLabel;
  final List<CheckinOverlayMetric> metrics;
  final String? scoreHome;
  final String? scoreAway;
  final String? teamHome;
  final String? teamAway;
  final String? achievementLabel;
}

class CheckinOverlayMetric {
  const CheckinOverlayMetric({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}
