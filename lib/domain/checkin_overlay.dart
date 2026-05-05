class CheckinOverlay {
  const CheckinOverlay({
    required this.type,
    this.layout = 'default',
    this.variantId,
    this.variantLabel,
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

  /// Filter category key (matches CheckinFilterOption.icon).
  /// Examples: bar_chart, location, schedule, trophy, score, session, pulse,
  /// minimal, favorite. Drives base styling decisions (e.g. score → scoreboard).
  final String type;

  /// Visual layout template. One of:
  /// - 'default': badges + headline + metrics + footer
  /// - 'compact': single-row pill with sport + headline
  /// - 'stats': headline + metrics grid only
  /// - 'minimal': single line with sport + time/location
  /// - 'scoreboard': home vs away score (paired with type=score)
  /// - 'achievement': badge chip + headline (paired with type=favorite)
  final String layout;
  final String? variantId;
  final String? variantLabel;
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
