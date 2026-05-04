import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/progress_overview.dart';
import '../repository/progress_repository.dart';
import '../util/const/app_constants.dart';

class ProgressProvider extends ChangeNotifier {
  ProgressProvider(this._repository);

  final ProgressRepository _repository;

  ProgressOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedFilterId;
  String? _selectedTimeRangeId;

  ProgressOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedFilterId => _selectedFilterId;
  String? get selectedTimeRangeId => _selectedTimeRangeId;

  Future<void> loadProgress() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getProgress();
      _selectedFilterId ??= _overview?.selectedFilterId;
      _selectedTimeRangeId ??= _overview?.selectedTimeRangeId;
    } catch (_) {
      _errorMessage = sl<AppConstants>().progressLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectFilter(String filterId) {
    if (_selectedFilterId == filterId) {
      return;
    }

    _selectedFilterId = filterId;
    notifyListeners();
  }

  void selectTimeRange(String timeRangeId) {
    if (_selectedTimeRangeId == timeRangeId) {
      return;
    }

    _selectedTimeRangeId = timeRangeId;
    notifyListeners();
  }
}
