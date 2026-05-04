import '../domain/checkin_filter_option.dart';
import '../domain/checkin_messages.dart';
import '../domain/checkin_overview.dart';

class CheckinDto {
  CheckinDto({
    required this.payload,
  });

  factory CheckinDto.fromJson(Map<String, dynamic> json) {
    return CheckinDto(payload: json);
  }

  final Map<String, dynamic> payload;

  CheckinOverview toDomain() {
    final messages = payload['messages'] as Map<String, dynamic>;

    return CheckinOverview(
      loadingLabel: payload['loadingLabel'] as String,
      captureHint: payload['captureHint'] as String,
      closeSemantics: payload['closeSemantics'] as String,
      flashSemantics: payload['flashSemantics'] as String,
      switchCameraSemantics: payload['switchCameraSemantics'] as String,
      gallerySemantics: payload['gallerySemantics'] as String,
      captureSemantics: payload['captureSemantics'] as String,
      filters: (payload['filters'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => CheckinFilterOption(
              label: item['label'] as String,
              icon: item['icon'] as String,
              isSelected: item['isSelected'] as bool,
            ),
          )
          .toList(growable: false),
      messages: CheckinMessages(
        captureSuccess: messages['captureSuccess'] as String,
        captureError: messages['captureError'] as String,
        cameraUnavailable: messages['cameraUnavailable'] as String,
        cameraPermissionDenied: messages['cameraPermissionDenied'] as String,
        filterAction: messages['filterAction'] as String,
      ),
    );
  }
}
