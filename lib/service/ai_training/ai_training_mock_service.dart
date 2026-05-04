import 'dart:convert';

import 'package:flutter/services.dart';

import 'ai_training_service_interface.dart';

class AiTrainingMockService implements AiTrainingServiceInterface {
  static const _assetPath = 'assets/data/ai_training_page.json';

  @override
  Future<Map<String, dynamic>> fetchAiTraining() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
