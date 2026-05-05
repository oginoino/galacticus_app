class AuthValidation {
  const AuthValidation({
    required this.emailRequired,
    required this.emailInvalid,
    required this.passwordRequired,
    required this.passwordTooShort,
    required this.passwordsDontMatch,
    required this.nameRequired,
    required this.termsRequired,
  });

  final String emailRequired;
  final String emailInvalid;
  final String passwordRequired;
  final String passwordTooShort;
  final String passwordsDontMatch;
  final String nameRequired;
  final String termsRequired;
}
