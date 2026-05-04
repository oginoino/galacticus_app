import '../domain/ai_training_messages.dart';
import '../domain/ai_training_metric.dart';
import '../domain/ai_training_overview.dart';
import '../domain/ai_training_reference.dart';

class AiTrainingDto {
  AiTrainingDto({
    required this.payload,
  });

  factory AiTrainingDto.fromJson(Map<String, dynamic> json) {
    return AiTrainingDto(payload: json);
  }

  final Map<String, dynamic> payload;

  AiTrainingOverview toDomain() {
    final messages = payload['messages'] as Map<String, dynamic>;

    return AiTrainingOverview(
      eyebrow: payload['eyebrow'] as String,
      title: payload['title'] as String,
      closeSemantics: payload['closeSemantics'] as String,
      referenceModes: (payload['referenceModes'] as List<dynamic>)
          .cast<String>()
          .toList(growable: false),
      references: (payload['references'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => AiTrainingReference(
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              kind: item['kind'] as String,
              durationLabel: item['durationLabel'] as String,
              highlightLabel: item['highlightLabel'] as String,
              imageAsset: item['imageAsset'] as String,
            ),
          )
          .toList(growable: false),
      metrics: (payload['metrics'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => AiTrainingMetric(
              label: item['label'] as String,
            ),
          )
          .toList(growable: false),
      instructionTitle: payload['instructionTitle'] as String,
      instructionBody: payload['instructionBody'] as String,
      startButtonLabel: payload['startButtonLabel'] as String,
      nextButtonLabel: payload['nextButtonLabel'] as String,
      progressTitle: payload['progressTitle'] as String,
      progressSubtitle: payload['progressSubtitle'] as String,
      previewLabel: payload['previewLabel'] as String,
      referenceSectionTitle: payload['referenceSectionTitle'] as String,
      modeSectionTitle: payload['modeSectionTitle'] as String,
      assistantLogoAsset: payload['assistantLogoAsset'] as String,
      backgroundAsset: payload['backgroundAsset'] as String,
      watermarkAsset: payload['watermarkAsset'] as String,
      previewAsset: payload['previewAsset'] as String,
      messages: AiTrainingMessages(
        startAction: messages['startAction'] as String,
        nextRepetitionAction: messages['nextRepetitionAction'] as String,
        mediaAction: messages['mediaAction'] as String,
        modeAction: messages['modeAction'] as String,
        cameraUnavailable: messages['cameraUnavailable'] as String,
        cameraPermissionDenied: messages['cameraPermissionDenied'] as String,
        recordBadgeLabel: messages['recordBadgeLabel'] as String,
        videoBadgeLabel: messages['videoBadgeLabel'] as String,
        switchLayoutHint: messages['switchLayoutHint'] as String,
        referenceThumbnailLabel: messages['referenceThumbnailLabel'] as String,
        cameraReadyLabel: messages['cameraReadyLabel'] as String,
        cameraInitializingLabel: messages['cameraInitializingLabel'] as String,
        referencePaneLabel: messages['referencePaneLabel'] as String,
      ),
    );
  }
}
