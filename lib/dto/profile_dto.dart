import '../domain/profile_gallery_item.dart';
import '../domain/profile_menu_item.dart';
import '../domain/profile_messages.dart';
import '../domain/profile_overview.dart';
import '../domain/profile_social_link.dart';
import '../domain/profile_stat.dart';
import '../domain/profile_tab.dart';
import '../domain/profile_ui_labels.dart';

class ProfileDto {
  ProfileDto({
    required this.payload,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(payload: json);
  }

  final Map<String, dynamic> payload;

  ProfileOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return ProfileOverview(
      name: payload['name'] as String,
      clubLabel: payload['clubLabel'] as String,
      levelLabel: payload['levelLabel'] as String,
      pointsLabel: payload['pointsLabel'] as String,
      bioLineOne: payload['bioLineOne'] as String,
      bioLineTwo: payload['bioLineTwo'] as String,
      heroImageAsset: payload['heroImageAsset'] as String,
      avatarAsset: payload['avatarAsset'] as String,
      stats: _mapList(
        payload['stats'] as List<dynamic>,
        (item) => ProfileStat(
          value: item['value'] as String,
          label: item['label'] as String,
        ),
      ),
      socialLinks: _mapList(
        payload['socialLinks'] as List<dynamic>,
        (item) => ProfileSocialLink(
          platform: item['platform'] as String,
          icon: item['icon'] as String,
        ),
      ),
      tabs: _mapList(
        payload['tabs'] as List<dynamic>,
        (item) => ProfileTab(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
        ),
      ),
      galleryItems: _mapList(
        payload['galleryItems'] as List<dynamic>,
        (item) => ProfileGalleryItem(
          imageAsset: item['imageAsset'] as String,
        ),
      ),
      menuItems: _mapList(
        (payload['menuItems'] as List<dynamic>?) ?? const <dynamic>[],
        (item) => ProfileMenuItem(
          id: item['id'] as String,
          label: item['label'] as String,
          icon: item['icon'] as String,
          isDestructive: (item['isDestructive'] as bool?) ?? false,
        ),
      ),
      uiLabels: ProfileUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      messages: ProfileMessages(
        quickAction: messages['quickAction'] as String,
        socialAction: messages['socialAction'] as String,
        tabAction: messages['tabAction'] as String,
        galleryAction: messages['galleryAction'] as String,
        menuTapAction: messages['menuTapAction'] as String,
        logoutAction: messages['logoutAction'] as String,
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
