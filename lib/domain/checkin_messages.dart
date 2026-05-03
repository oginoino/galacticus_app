class CheckinMessages {
  const CheckinMessages({
    required this.captureSuccess,
    required this.captureError,
    required this.cameraUnavailable,
    required this.cameraPermissionDenied,
    required this.filterAction,
  });

  final String captureSuccess;
  final String captureError;
  final String cameraUnavailable;
  final String cameraPermissionDenied;
  final String filterAction;
}
