import 'dart:convert';

import 'package:flutter/services.dart';

import 'matches_service_interface.dart';

class MatchesMockService implements MatchesServiceInterface {
  static const _assetPath = 'assets/data/matches_page.json';

  @override
  Future<Map<String, dynamic>> fetchMatches() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
