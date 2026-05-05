import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/auth_overview.dart';
import '../repository/auth_repository.dart';
import '../util/const/app_constants.dart';

enum AuthSubmissionStatus { idle, submitting, success, failure }

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._repository);

  final AuthRepository _repository;

  AuthOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  AuthSubmissionStatus _loginStatus = AuthSubmissionStatus.idle;
  AuthSubmissionStatus _registerStatus = AuthSubmissionStatus.idle;
  AuthSubmissionStatus _recoveryStatus = AuthSubmissionStatus.idle;

  AuthOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthSubmissionStatus get loginStatus => _loginStatus;
  AuthSubmissionStatus get registerStatus => _registerStatus;
  AuthSubmissionStatus get recoveryStatus => _recoveryStatus;

  Future<void> loadOverview() async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getOverview();
    } catch (_) {
      _errorMessage = _overview?.messages.loadErrorMessage ??
          sl<AppConstants>().authLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitLogin({
    required String email,
    required String password,
  }) async {
    _loginStatus = AuthSubmissionStatus.submitting;
    notifyListeners();

    try {
      await _repository.submitLogin(email: email, password: password);
      _loginStatus = AuthSubmissionStatus.success;
      notifyListeners();
      return true;
    } catch (_) {
      _loginStatus = AuthSubmissionStatus.failure;
      notifyListeners();
      return false;
    }
  }

  Future<bool> submitRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    _registerStatus = AuthSubmissionStatus.submitting;
    notifyListeners();

    try {
      await _repository.submitRegister(
        name: name,
        email: email,
        password: password,
      );
      _registerStatus = AuthSubmissionStatus.success;
      notifyListeners();
      return true;
    } catch (_) {
      _registerStatus = AuthSubmissionStatus.failure;
      notifyListeners();
      return false;
    }
  }

  Future<bool> submitPasswordRecovery({required String email}) async {
    _recoveryStatus = AuthSubmissionStatus.submitting;
    notifyListeners();

    try {
      await _repository.submitPasswordRecovery(email: email);
      _recoveryStatus = AuthSubmissionStatus.success;
      notifyListeners();
      return true;
    } catch (_) {
      _recoveryStatus = AuthSubmissionStatus.failure;
      notifyListeners();
      return false;
    }
  }

  void resetSubmissionStatus() {
    _loginStatus = AuthSubmissionStatus.idle;
    _registerStatus = AuthSubmissionStatus.idle;
    _recoveryStatus = AuthSubmissionStatus.idle;
    notifyListeners();
  }
}
