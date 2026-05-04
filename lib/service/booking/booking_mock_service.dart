import 'dart:convert';

import 'package:flutter/services.dart';

import 'booking_service_interface.dart';

class BookingMockService implements BookingServiceInterface {
  static const _assetPath = 'assets/data/booking_page.json';

  @override
  Future<Map<String, dynamic>> fetchBooking() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
