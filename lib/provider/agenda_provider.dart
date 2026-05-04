import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/agenda_overview.dart';
import '../repository/agenda_repository.dart';
import '../util/const/app_constants.dart';

class AgendaProvider extends ChangeNotifier {
  AgendaProvider(this._repository);

  final AgendaRepository _repository;

  AgendaOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  AgendaOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAgenda() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getAgenda();
    } catch (_) {
      _errorMessage = sl<AppConstants>().agendaLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
