import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/dashboard_overview.dart';
import '../repository/home_repository.dart';
import '../util/const/app_constants.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this._repository);

  final HomeRepository _repository;

  DashboardOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedTabIndex = 0;

  DashboardOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTabIndex => _selectedTabIndex;

  Future<void> loadDashboard() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getDashboard();
    } catch (_) {
      _errorMessage = sl<AppConstants>().homeLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
