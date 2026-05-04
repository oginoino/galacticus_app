import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/notifications_overview.dart';
import '../repository/notifications_repository.dart';
import '../util/const/app_constants.dart';

class NotificationsProvider extends ChangeNotifier {
  NotificationsProvider(this._repository);

  final NotificationsRepository _repository;

  NotificationsOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  NotificationsOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadNotifications() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getNotifications();
    } catch (_) {
      _errorMessage = sl<AppConstants>().notificationsLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
