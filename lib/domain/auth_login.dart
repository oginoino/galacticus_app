class AuthLogin {
  const AuthLogin({
    required this.title,
    required this.subtitle,
    required this.emailLabel,
    required this.emailPlaceholder,
    required this.passwordLabel,
    required this.passwordPlaceholder,
    required this.submitLabel,
    required this.forgotLabel,
    required this.socialDividerLabel,
    required this.registerPromptLabel,
    required this.registerActionLabel,
  });

  final String title;
  final String subtitle;
  final String emailLabel;
  final String emailPlaceholder;
  final String passwordLabel;
  final String passwordPlaceholder;
  final String submitLabel;
  final String forgotLabel;
  final String socialDividerLabel;
  final String registerPromptLabel;
  final String registerActionLabel;
}
