class AiTrainingMessages {
  const AiTrainingMessages({
    required this.startAction,
    required this.nextRepetitionAction,
    required this.mediaAction,
    required this.modeAction,
    required this.cameraUnavailable,
    required this.cameraPermissionDenied,
    required this.recordBadgeLabel,
    required this.videoBadgeLabel,
    required this.switchLayoutHint,
    required this.referenceThumbnailLabel,
    required this.cameraReadyLabel,
    required this.cameraInitializingLabel,
    required this.referencePaneLabel,
  });

  final String startAction;
  final String nextRepetitionAction;
  final String mediaAction;
  final String modeAction;
  final String cameraUnavailable;
  final String cameraPermissionDenied;
  final String recordBadgeLabel;
  final String videoBadgeLabel;
  final String switchLayoutHint;
  final String referenceThumbnailLabel;
  final String cameraReadyLabel;
  final String cameraInitializingLabel;
  final String referencePaneLabel;
}
