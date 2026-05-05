import 'auth_login.dart';
import 'auth_messages.dart';
import 'auth_password_recovery.dart';
import 'auth_register.dart';
import 'auth_social_provider.dart';
import 'auth_validation.dart';

class AuthOverview {
  const AuthOverview({
    required this.brandName,
    required this.brandTagline,
    required this.login,
    required this.register,
    required this.passwordRecovery,
    required this.socialProviders,
    required this.messages,
    required this.validation,
  });

  final String brandName;
  final String brandTagline;
  final AuthLogin login;
  final AuthRegister register;
  final AuthPasswordRecovery passwordRecovery;
  final List<AuthSocialProvider> socialProviders;
  final AuthMessages messages;
  final AuthValidation validation;
}
