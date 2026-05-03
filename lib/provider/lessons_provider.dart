import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/lessons_overview.dart';
import '../repository/lessons_repository.dart';
import '../util/const/app_constants.dart';

class LessonsProvider extends ChangeNotifier {
  LessonsProvider(this._repository);

  final LessonsRepository _repository;

  LessonsOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  LessonsOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadLessons() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getLessons();
    } catch (_) {
      _errorMessage = sl<AppConstants>().lessonsLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
