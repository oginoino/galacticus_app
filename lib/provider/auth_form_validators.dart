import '../domain/auth_validation.dart';

class AuthFormValidators {
  AuthFormValidators(this.validation);

  final AuthValidation validation;

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return validation.emailRequired;
    if (!_emailRegex.hasMatch(trimmed)) return validation.emailInvalid;
    return null;
  }

  String? validatePassword(String? value, {bool checkLength = true}) {
    final v = value ?? '';
    if (v.isEmpty) return validation.passwordRequired;
    if (checkLength && v.length < 8) return validation.passwordTooShort;
    return null;
  }

  String? validatePasswordMatch(String? value, String original) {
    if ((value ?? '') != original) return validation.passwordsDontMatch;
    return null;
  }

  String? validateName(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return validation.nameRequired;
    return null;
  }

  String? validateTerms(bool accepted) {
    if (!accepted) return validation.termsRequired;
    return null;
  }
}
