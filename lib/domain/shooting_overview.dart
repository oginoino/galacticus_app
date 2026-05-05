import 'shooting_messages.dart';
import 'shot_item.dart';

class ShootingOverview {
  const ShootingOverview({
    required this.title,
    required this.subtitle,
    required this.modeLabel,
    required this.modeEnabledByDefault,
    required this.helpTitle,
    required this.helpText,
    required this.galleryTitle,
    required this.items,
    required this.messages,
  });

  final String title;
  final String subtitle;
  final String modeLabel;
  final bool modeEnabledByDefault;
  final String helpTitle;
  final String helpText;
  final String galleryTitle;
  final List<ShotItem> items;
  final ShootingMessages messages;
}
