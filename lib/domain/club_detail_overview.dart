import 'club_member.dart';
import 'club_photo.dart';
import 'club_session.dart';

class ClubDetailOverview {
  const ClubDetailOverview({
    required this.slug,
    required this.name,
    required this.headline,
    required this.heroImageAsset,
    required this.membersLabel,
    required this.privacyLabel,
    required this.headerCounterLabel,
    required this.tags,
    required this.descriptionTitle,
    required this.description,
    required this.membersTitle,
    required this.members,
    required this.sessionsTitle,
    required this.sessions,
    required this.photosTitle,
    required this.photos,
    required this.rulesTitle,
    required this.rules,
    required this.joinLabel,
    required this.shareLabel,
    required this.loadErrorMessage,
  });

  final String slug;
  final String name;
  final String headline;
  final String heroImageAsset;
  final String membersLabel;
  final String privacyLabel;
  final String headerCounterLabel;
  final List<String> tags;
  final String descriptionTitle;
  final String description;
  final String membersTitle;
  final List<ClubMember> members;
  final String sessionsTitle;
  final List<ClubSession> sessions;
  final String photosTitle;
  final List<ClubPhoto> photos;
  final String rulesTitle;
  final List<String> rules;
  final String joinLabel;
  final String shareLabel;
  final String loadErrorMessage;
}
