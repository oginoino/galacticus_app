import 'package:flutter/foundation.dart';

import '../di/di.dart';
import '../domain/match_overview.dart';
import '../domain/match_record.dart';
import '../repository/matches_repository.dart';
import '../util/const/app_constants.dart';

class MatchesProvider extends ChangeNotifier {
  MatchesProvider(this._repository);

  final MatchesRepository _repository;

  MatchOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedFilterIndex = 0;

  MatchOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedFilterIndex => _selectedFilterIndex;

  List<MatchRecord> get visibleItems {
    final overview = _overview;
    if (overview == null) return const [];
    if (_selectedFilterIndex < 0 ||
        _selectedFilterIndex >= overview.filters.length) {
      return overview.items;
    }
    final value = overview.filters[_selectedFilterIndex].value;
    if (value == 'all') return overview.items;
    if (value == 'confirmed') {
      return overview.items
          .where((item) => item.statusHighlighted)
          .toList(growable: false);
    }
    return overview.items
        .where((item) => item.sportKey == value)
        .toList(growable: false);
  }

  Future<void> loadMatches() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getMatches();
      _selectedFilterIndex = _overview!.filters.indexWhere((c) => c.isSelected);
      if (_selectedFilterIndex < 0) _selectedFilterIndex = 0;
    } catch (_) {
      _errorMessage = sl<AppConstants>().matchesLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectFilter(int index) {
    if (index == _selectedFilterIndex) return;
    _selectedFilterIndex = index;
    notifyListeners();
  }
}
