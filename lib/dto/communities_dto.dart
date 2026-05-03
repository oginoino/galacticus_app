import '../domain/communities_messages.dart';
import '../domain/communities_overview.dart';
import '../domain/communities_ui_labels.dart';
import '../domain/community_category.dart';
import '../domain/discover_club.dart';
import '../domain/user_club.dart';

class CommunitiesDto {
  CommunitiesDto({
    required this.payload,
  });

  factory CommunitiesDto.fromJson(Map<String, dynamic> json) {
    return CommunitiesDto(payload: json);
  }

  final Map<String, dynamic> payload;

  CommunitiesOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return CommunitiesOverview(
      title: payload['title'] as String,
      searchPlaceholder: payload['searchPlaceholder'] as String,
      myClubsTitle: payload['myClubsTitle'] as String,
      discoverTitle: payload['discoverTitle'] as String,
      viewAllLabel: payload['viewAllLabel'] as String,
      currentUserAvatarAsset: payload['currentUserAvatarAsset'] as String,
      myClubs: _mapList(
        payload['myClubs'] as List<dynamic>,
        (item) => UserClub(
          title: item['title'] as String,
          membersLabel: item['membersLabel'] as String,
          imageAsset: item['imageAsset'] as String,
        ),
      ),
      categories: _mapList(
        payload['categories'] as List<dynamic>,
        (item) => CommunityCategory(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
        ),
      ),
      discoverClubs: _mapList(
        payload['discoverClubs'] as List<dynamic>,
        (item) => DiscoverClub(
          title: item['title'] as String,
          tagsLabel: item['tagsLabel'] as String,
          subtitle: item['subtitle'] as String,
          membersLabel: item['membersLabel'] as String,
          joinLabel: item['joinLabel'] as String,
          imageAsset: item['imageAsset'] as String,
          memberAvatarAssets: (item['memberAvatarAssets'] as List<dynamic>)
              .cast<String>()
              .toList(growable: false),
        ),
      ),
      uiLabels: CommunitiesUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      messages: CommunitiesMessages(
        quickAction: messages['quickAction'] as String,
        searchAction: messages['searchAction'] as String,
        viewAllAction: messages['viewAllAction'] as String,
        filterAction: messages['filterAction'] as String,
        joinAction: messages['joinAction'] as String,
      ),
    );
  }

  List<T> _mapList<T>(
    List<dynamic> source,
    T Function(Map<String, dynamic> json) mapper,
  ) {
    return source
        .cast<Map<String, dynamic>>()
        .map(mapper)
        .toList(growable: false);
  }
}
