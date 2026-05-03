import 'communities_messages.dart';
import 'communities_ui_labels.dart';
import 'community_category.dart';
import 'discover_club.dart';
import 'user_club.dart';

class CommunitiesOverview {
  const CommunitiesOverview({
    required this.title,
    required this.searchPlaceholder,
    required this.myClubsTitle,
    required this.discoverTitle,
    required this.viewAllLabel,
    required this.currentUserAvatarAsset,
    required this.myClubs,
    required this.categories,
    required this.discoverClubs,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final String searchPlaceholder;
  final String myClubsTitle;
  final String discoverTitle;
  final String viewAllLabel;
  final String currentUserAvatarAsset;
  final List<UserClub> myClubs;
  final List<CommunityCategory> categories;
  final List<DiscoverClub> discoverClubs;
  final CommunitiesUiLabels uiLabels;
  final CommunitiesMessages messages;
}
