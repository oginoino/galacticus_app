import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/feed_overview.dart';
import '../repository/feed_repository.dart';
import '../util/const/app_constants.dart';

class FeedProvider extends ChangeNotifier {
  FeedProvider(this._repository);

  final FeedRepository _repository;

  FeedOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  FeedOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFeed() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getFeed();
    } catch (_) {
      _errorMessage = sl<AppConstants>().feedLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
