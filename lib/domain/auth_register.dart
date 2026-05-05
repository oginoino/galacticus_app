class AuthRegister {
  const AuthRegister({
    required this.title,
    required this.subtitle,
    required this.nameLabel,
    required this.namePlaceholder,
    required this.emailLabel,
    required this.emailPlaceholder,
    required this.passwordLabel,
    required this.passwordPlaceholder,
    required this.confirmPasswordLabel,
    required this.confirmPasswordPlaceholder,
    required this.termsLabel,
    required this.submitLabel,
    required this.loginPromptLabel,
    required this.loginActionLabel,
  });

  final String title;
  final String subtitle;
  final String nameLabel;
  final String namePlaceholder;
  final String emailLabel;
  final String emailPlaceholder;
  final String passwordLabel;
  final String passwordPlaceholder;
  final String confirmPasswordLabel;
  final String confirmPasswordPlaceholder;
  final String termsLabel;
  final String submitLabel;
  final String loginPromptLabel;
  final String loginActionLabel;
}
