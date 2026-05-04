import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/ranking_overview.dart';
import '../repository/ranking_repository.dart';
import '../util/const/app_constants.dart';

class RankingProvider extends ChangeNotifier {
  RankingProvider(this._repository);

  final RankingRepository _repository;

  RankingOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedCategoryId;

  RankingOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedCategoryId => _selectedCategoryId;

  Future<void> loadRanking() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getRanking();
      final categories = _overview?.categories;
      if (_selectedCategoryId == null && categories != null && categories.isNotEmpty) {
        _selectedCategoryId = categories.first.id;
      }
    } catch (_) {
      _errorMessage = sl<AppConstants>().rankingLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String categoryId) {
    if (_selectedCategoryId == categoryId) {
      return;
    }
    _selectedCategoryId = categoryId;
    notifyListeners();
  }
}
