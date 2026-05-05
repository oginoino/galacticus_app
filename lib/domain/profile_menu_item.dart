class ProfileMenuItem {
  const ProfileMenuItem({
    required this.id,
    required this.label,
    required this.icon,
    this.isDestructive = false,
  });

  final String id;
  final String label;
  final String icon;
  final bool isDestructive;
}
