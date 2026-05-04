import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/checkin_overview.dart';
import '../repository/checkin_repository.dart';
import '../util/const/app_constants.dart';

class CheckinProvider extends ChangeNotifier {
  CheckinProvider(this._repository);

  final CheckinRepository _repository;

  CheckinOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  CheckinOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCheckin() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getCheckin();
    } catch (_) {
      _errorMessage = sl<AppConstants>().checkinLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
