import 'package:flutter/foundation.dart';

import '../di/di.dart';
import '../domain/club_detail_overview.dart';
import '../repository/club_detail_repository.dart';
import '../util/const/app_constants.dart';

class ClubDetailProvider extends ChangeNotifier {
  ClubDetailProvider(this._repository);

  final ClubDetailRepository _repository;

  ClubDetailOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  ClubDetailOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadClub({String? slug}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getClub(slug: slug);
    } catch (_) {
      _errorMessage = sl<AppConstants>().clubDetailLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
