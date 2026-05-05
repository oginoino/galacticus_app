import 'checkin_overlay.dart';

class CheckinFilterOption {
  const CheckinFilterOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    this.overlays = const [],
  });

  final String label;
  final String icon;
  final bool isSelected;
  final List<CheckinOverlay> overlays;
}
