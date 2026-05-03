import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/communities_overview.dart';
import '../repository/communities_repository.dart';
import '../util/const/app_constants.dart';

class CommunitiesProvider extends ChangeNotifier {
  CommunitiesProvider(this._repository);

  final CommunitiesRepository _repository;

  CommunitiesOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  CommunitiesOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCommunities() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getCommunities();
    } catch (_) {
      _errorMessage = sl<AppConstants>().communitiesLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
