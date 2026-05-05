import 'package:flutter/foundation.dart';

import '../di/di.dart';
import '../domain/shooting_overview.dart';
import '../repository/shooting_repository.dart';
import '../util/const/app_constants.dart';

class ShootingProvider extends ChangeNotifier {
  ShootingProvider(this._repository);

  final ShootingRepository _repository;

  ShootingOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;
  bool _modeEnabled = true;

  ShootingOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get modeEnabled => _modeEnabled;

  Future<void> loadShooting() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getShooting();
      _modeEnabled = _overview!.modeEnabledByDefault;
    } catch (_) {
      _errorMessage = sl<AppConstants>().shootingLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleMode() {
    _modeEnabled = !_modeEnabled;
    notifyListeners();
  }
}
