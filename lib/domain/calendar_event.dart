class CalendarEvent {
  const CalendarEvent({
    required this.type,
    required this.title,
    required this.subtitle,
    this.referenceId,
  });

  /// Discriminator: 'training' | 'match' | 'event' | 'booking' | 'lesson'
  /// | 'club' | 'checkin'. Drives route dispatch in the UI.
  final String type;
  final String title;
  final String subtitle;

  /// Identifier passed in path-parameterized routes (e.g. /treino/:id).
  /// Optional — list pages don't need it.
  final String? referenceId;
}
