import 'dart:convert';

import 'package:flutter/services.dart';

import 'progress_service_interface.dart';

class ProgressMockService implements ProgressServiceInterface {
  static const _assetPath = 'assets/data/progress_page.json';

  @override
  Future<Map<String, dynamic>> fetchProgress() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
