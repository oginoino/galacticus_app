import 'dart:convert';

import 'package:flutter/services.dart';

import 'ranking_service_interface.dart';

class RankingMockService implements RankingServiceInterface {
  static const _assetPath = 'assets/data/ranking_page.json';

  @override
  Future<Map<String, dynamic>> fetchRanking() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
