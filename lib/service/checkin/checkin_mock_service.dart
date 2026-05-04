import 'dart:convert';

import 'package:flutter/services.dart';

import 'checkin_service_interface.dart';

class CheckinMockService implements CheckinServiceInterface {
  static const _assetPath = 'assets/data/checkin_page.json';

  @override
  Future<Map<String, dynamic>> fetchCheckin() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
