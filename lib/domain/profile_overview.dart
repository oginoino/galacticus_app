import 'profile_gallery_item.dart';
import 'profile_messages.dart';
import 'profile_social_link.dart';
import 'profile_stat.dart';
import 'profile_tab.dart';
import 'profile_ui_labels.dart';

class ProfileOverview {
  const ProfileOverview({
    required this.name,
    required this.clubLabel,
    required this.levelLabel,
    required this.pointsLabel,
    required this.bioLineOne,
    required this.bioLineTwo,
    required this.heroImageAsset,
    required this.avatarAsset,
    required this.stats,
    required this.socialLinks,
    required this.tabs,
    required this.galleryItems,
    required this.uiLabels,
    required this.messages,
  });

  final String name;
  final String clubLabel;
  final String levelLabel;
  final String pointsLabel;
  final String bioLineOne;
  final String bioLineTwo;
  final String heroImageAsset;
  final String avatarAsset;
  final List<ProfileStat> stats;
  final List<ProfileSocialLink> socialLinks;
  final List<ProfileTab> tabs;
  final List<ProfileGalleryItem> galleryItems;
  final ProfileUiLabels uiLabels;
  final ProfileMessages messages;
}
