import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/profile_overview.dart';
import '../repository/profile_repository.dart';
import '../util/const/app_constants.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this._repository);

  final ProfileRepository _repository;

  ProfileOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getProfile();
    } catch (_) {
      _errorMessage = sl<AppConstants>().profileLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
