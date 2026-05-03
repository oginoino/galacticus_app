import 'dart:convert';

import 'package:flutter/services.dart';

import 'communities_service_interface.dart';

class CommunitiesMockService implements CommunitiesServiceInterface {
  static const _assetPath = 'assets/data/communities_page.json';

  @override
  Future<Map<String, dynamic>> fetchCommunities() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
