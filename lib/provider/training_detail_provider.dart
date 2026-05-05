import 'package:flutter/foundation.dart';

import '../di/di.dart';
import '../domain/training_detail_overview.dart';
import '../repository/training_detail_repository.dart';
import '../util/const/app_constants.dart';

class TrainingDetailProvider extends ChangeNotifier {
  TrainingDetailProvider(this._repository);

  final TrainingDetailRepository _repository;

  TrainingDetailOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  TrainingDetailOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadTraining({String? id}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getTrainingDetail(id: id);
    } catch (_) {
      _errorMessage = sl<AppConstants>().trainingDetailLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
