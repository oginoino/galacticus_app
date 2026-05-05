import 'dart:convert';

import 'package:flutter/services.dart';

import 'training_detail_service_interface.dart';

class TrainingDetailMockService implements TrainingDetailServiceInterface {
  static const _assetPath = 'assets/data/training_detail_page.json';

  @override
  Future<Map<String, dynamic>> fetchTrainingDetail() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
