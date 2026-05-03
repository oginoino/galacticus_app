import 'dart:convert';

import 'package:flutter/services.dart';

import 'home_service_interface.dart';

class HomeMockService implements HomeServiceInterface {
  static const _assetPath = 'assets/data/home_feed.json';

  @override
  Future<Map<String, dynamic>> fetchHomeFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
