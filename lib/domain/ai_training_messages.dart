class AiTrainingMessages {
  const AiTrainingMessages({
    required this.startAction,
    required this.nextRepetitionAction,
    required this.mediaAction,
    required this.modeAction,
    required this.cameraUnavailable,
    required this.cameraPermissionDenied,
  });

  final String startAction;
  final String nextRepetitionAction;
  final String mediaAction;
  final String modeAction;
  final String cameraUnavailable;
  final String cameraPermissionDenied;
}
