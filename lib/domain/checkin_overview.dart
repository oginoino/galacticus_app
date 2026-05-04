import 'checkin_filter_option.dart';
import 'checkin_messages.dart';

class CheckinOverview {
  const CheckinOverview({
    required this.loadingLabel,
    required this.captureHint,
    required this.closeSemantics,
    required this.flashSemantics,
    required this.switchCameraSemantics,
    required this.gallerySemantics,
    required this.captureSemantics,
    required this.filters,
    required this.messages,
  });

  final String loadingLabel;
  final String captureHint;
  final String closeSemantics;
  final String flashSemantics;
  final String switchCameraSemantics;
  final String gallerySemantics;
  final String captureSemantics;
  final List<CheckinFilterOption> filters;
  final CheckinMessages messages;
}
