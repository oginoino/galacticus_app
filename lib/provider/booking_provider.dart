import 'package:flutter/material.dart';

import '../di/di.dart';
import '../domain/booking_overview.dart';
import '../repository/booking_repository.dart';
import '../util/const/app_constants.dart';

class BookingProvider extends ChangeNotifier {
  BookingProvider(this._repository);

  final BookingRepository _repository;

  BookingOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  BookingOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadBooking() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getBooking();
    } catch (_) {
      _errorMessage = sl<AppConstants>().bookingLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
