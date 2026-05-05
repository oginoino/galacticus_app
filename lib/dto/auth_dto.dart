import '../domain/auth_login.dart';
import '../domain/auth_messages.dart';
import '../domain/auth_overview.dart';
import '../domain/auth_password_recovery.dart';
import '../domain/auth_register.dart';
import '../domain/auth_social_provider.dart';
import '../domain/auth_validation.dart';

class AuthDto {
  AuthDto({required this.payload});

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(payload: json);
  }

  final Map<String, dynamic> payload;

  AuthOverview toDomain() {
    final messages = payload['messages'] as Map<String, dynamic>;
    final validation = payload['validation'] as Map<String, dynamic>;
    final login = payload['login'] as Map<String, dynamic>;
    final register = payload['register'] as Map<String, dynamic>;
    final recovery = payload['passwordRecovery'] as Map<String, dynamic>;
    final providers =
        (payload['socialProviders'] as List<dynamic>? ?? const <dynamic>[])
            .cast<Map<String, dynamic>>();

    return AuthOverview(
      brandName: payload['brandName'] as String,
      brandTagline: payload['brandTagline'] as String,
      messages: AuthMessages(
        loadErrorMessage: messages['loadErrorMessage'] as String,
        submitErrorMessage: messages['submitErrorMessage'] as String,
        loginSuccessMessage: messages['loginSuccessMessage'] as String,
        registerSuccessMessage: messages['registerSuccessMessage'] as String,
        recoverySuccessMessage: messages['recoverySuccessMessage'] as String,
        socialAction: messages['socialAction'] as String,
      ),
      validation: AuthValidation(
        emailRequired: validation['emailRequired'] as String,
        emailInvalid: validation['emailInvalid'] as String,
        passwordRequired: validation['passwordRequired'] as String,
        passwordTooShort: validation['passwordTooShort'] as String,
        passwordsDontMatch: validation['passwordsDontMatch'] as String,
        nameRequired: validation['nameRequired'] as String,
        termsRequired: validation['termsRequired'] as String,
      ),
      login: AuthLogin(
        title: login['title'] as String,
        subtitle: login['subtitle'] as String,
        emailLabel: login['emailLabel'] as String,
        emailPlaceholder: login['emailPlaceholder'] as String,
        passwordLabel: login['passwordLabel'] as String,
        passwordPlaceholder: login['passwordPlaceholder'] as String,
        submitLabel: login['submitLabel'] as String,
        forgotLabel: login['forgotLabel'] as String,
        socialDividerLabel: login['socialDividerLabel'] as String,
        registerPromptLabel: login['registerPromptLabel'] as String,
        registerActionLabel: login['registerActionLabel'] as String,
      ),
      register: AuthRegister(
        title: register['title'] as String,
        subtitle: register['subtitle'] as String,
        nameLabel: register['nameLabel'] as String,
        namePlaceholder: register['namePlaceholder'] as String,
        emailLabel: register['emailLabel'] as String,
        emailPlaceholder: register['emailPlaceholder'] as String,
        passwordLabel: register['passwordLabel'] as String,
        passwordPlaceholder: register['passwordPlaceholder'] as String,
        confirmPasswordLabel: register['confirmPasswordLabel'] as String,
        confirmPasswordPlaceholder:
            register['confirmPasswordPlaceholder'] as String,
        termsLabel: register['termsLabel'] as String,
        submitLabel: register['submitLabel'] as String,
        loginPromptLabel: register['loginPromptLabel'] as String,
        loginActionLabel: register['loginActionLabel'] as String,
      ),
      passwordRecovery: AuthPasswordRecovery(
        title: recovery['title'] as String,
        subtitle: recovery['subtitle'] as String,
        emailLabel: recovery['emailLabel'] as String,
        emailPlaceholder: recovery['emailPlaceholder'] as String,
        submitLabel: recovery['submitLabel'] as String,
        loginPromptLabel: recovery['loginPromptLabel'] as String,
        loginActionLabel: recovery['loginActionLabel'] as String,
      ),
      socialProviders: providers
          .map(
            (item) => AuthSocialProvider(
              id: item['id'] as String,
              label: item['label'] as String,
              icon: item['icon'] as String,
            ),
          )
          .toList(growable: false),
    );
  }
}
