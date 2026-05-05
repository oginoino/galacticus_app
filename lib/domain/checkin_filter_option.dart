import 'checkin_overlay.dart';

class CheckinFilterOption {
  const CheckinFilterOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    this.overlay,
  });

  final String label;
  final String icon;
  final bool isSelected;
  final CheckinOverlay? overlay;
}
