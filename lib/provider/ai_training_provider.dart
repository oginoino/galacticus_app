import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/ai_training_overview.dart';
import '../repository/ai_training_repository.dart';
import '../util/const/app_constants.dart';

class AiTrainingProvider extends ChangeNotifier {
  AiTrainingProvider(this._repository);

  final AiTrainingRepository _repository;

  AiTrainingOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  AiTrainingOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAiTraining() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getAiTraining();
    } catch (_) {
      _errorMessage = sl<AppConstants>().aiTrainingLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
