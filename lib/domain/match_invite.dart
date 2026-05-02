class MatchInvite {
  const MatchInvite({
    required this.hostName,
    required this.sport,
    required this.schedule,
    required this.location,
    required this.availability,
    required this.isLastSpot,
  });

  final String hostName;
  final String sport;
  final String schedule;
  final String location;
  final String availability;
  final bool isLastSpot;
}
