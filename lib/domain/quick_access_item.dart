class QuickAccessItem {
  const QuickAccessItem({
    required this.title,
    required this.subtitle,
    required this.accentLabel,
    required this.icon,
    required this.type,
    required this.backgroundAsset,
    required this.content,
  });

  final String title;
  final String subtitle;
  final String accentLabel;
  final String icon;
  final String type;
  final String backgroundAsset;
  final Map<String, dynamic> content;
}
