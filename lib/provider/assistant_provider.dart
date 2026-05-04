import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/assistant_overview.dart';
import '../repository/assistant_repository.dart';
import '../util/const/app_constants.dart';

class AssistantProvider extends ChangeNotifier {
  AssistantProvider(this._repository);

  final AssistantRepository _repository;

  AssistantOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  AssistantOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAssistant() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getAssistant();
    } catch (_) {
      _errorMessage = sl<AppConstants>().assistantLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
