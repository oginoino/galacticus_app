class AuthMessages {
  const AuthMessages({
    required this.loadErrorMessage,
    required this.submitErrorMessage,
    required this.loginSuccessMessage,
    required this.registerSuccessMessage,
    required this.recoverySuccessMessage,
    required this.socialAction,
  });

  final String loadErrorMessage;
  final String submitErrorMessage;
  final String loginSuccessMessage;
  final String registerSuccessMessage;
  final String recoverySuccessMessage;
  final String socialAction;
}
