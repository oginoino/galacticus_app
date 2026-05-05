import '../domain/checkin_filter_option.dart';
import '../domain/checkin_messages.dart';
import '../domain/checkin_overlay.dart';
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
              overlays: (item['overlays'] as List<dynamic>? ?? const [])
                  .map(parseCheckinOverlay)
                  .whereType<CheckinOverlay>()
                  .toList(growable: false),
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

CheckinOverlay? parseCheckinOverlay(Object? value) {
  if (value is! Map) return null;
  final map = value.cast<String, dynamic>();
  return CheckinOverlay(
    type: map['type'] as String,
    layout: (map['layout'] as String?) ?? 'default',
    variantId: map['variantId'] as String?,
    variantLabel: map['variantLabel'] as String?,
    headline: map['headline'] as String?,
    subheadline: map['subheadline'] as String?,
    sportLabel: map['sportLabel'] as String?,
    locationLabel: map['locationLabel'] as String?,
    weatherLabel: map['weatherLabel'] as String?,
    timeLabel: map['timeLabel'] as String?,
    metrics: (map['metrics'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>()
        .map(
          (item) => CheckinOverlayMetric(
            value: item['value'] as String,
            label: item['label'] as String,
          ),
        )
        .toList(growable: false),
    scoreHome: map['scoreHome'] as String?,
    scoreAway: map['scoreAway'] as String?,
    teamHome: map['teamHome'] as String?,
    teamAway: map['teamAway'] as String?,
    achievementLabel: map['achievementLabel'] as String?,
  );
}
