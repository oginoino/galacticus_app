import '../domain/club_detail_overview.dart';
import '../domain/club_member.dart';
import '../domain/club_photo.dart';
import '../domain/club_session.dart';

class ClubDetailDto {
  ClubDetailDto({required this.payload});

  factory ClubDetailDto.fromJson(Map<String, dynamic> json) {
    return ClubDetailDto(payload: json);
  }

  final Map<String, dynamic> payload;

  /// Returns the club for [slug] if present in payload['clubs']; otherwise the
  /// first club. The mock JSON keeps a list under 'clubs'.
  ClubDetailOverview toDomain({String? slug}) {
    final clubs = (payload['clubs'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final match = clubs.firstWhere(
      (c) => c['slug'] == slug,
      orElse: () => clubs.first,
    );
    return _parseClub(match);
  }

  ClubDetailOverview _parseClub(Map<String, dynamic> club) {
    return ClubDetailOverview(
      slug: club['slug'] as String,
      name: club['name'] as String,
      headline: club['headline'] as String,
      heroImageAsset: club['heroImageAsset'] as String,
      membersLabel: club['membersLabel'] as String,
      privacyLabel: club['privacyLabel'] as String,
      headerCounterLabel: club['headerCounterLabel'] as String,
      tags: (club['tags'] as List<dynamic>).cast<String>(),
      descriptionTitle: club['descriptionTitle'] as String,
      description: club['description'] as String,
      membersTitle: club['membersTitle'] as String,
      members: (club['members'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => ClubMember(
              name: item['name'] as String,
              roleLabel: item['roleLabel'] as String,
              avatarAsset: item['avatarAsset'] as String?,
              initials: item['initials'] as String?,
            ),
          )
          .toList(growable: false),
      sessionsTitle: club['sessionsTitle'] as String,
      sessions: (club['sessions'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => ClubSession(
              title: item['title'] as String,
              dayLabel: item['dayLabel'] as String,
              timeLabel: item['timeLabel'] as String,
              locationLabel: item['locationLabel'] as String,
              capacityLabel: item['capacityLabel'] as String,
            ),
          )
          .toList(growable: false),
      photosTitle: club['photosTitle'] as String,
      photos: (club['photos'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => ClubPhoto(
              imageAsset: item['imageAsset'] as String,
              captionLabel: item['captionLabel'] as String?,
            ),
          )
          .toList(growable: false),
      rulesTitle: club['rulesTitle'] as String,
      rules: (club['rules'] as List<dynamic>).cast<String>(),
      joinLabel: club['joinLabel'] as String,
      shareLabel: club['shareLabel'] as String,
      loadErrorMessage: payload['loadErrorMessage'] as String,
    );
  }
}
