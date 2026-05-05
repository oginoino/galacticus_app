import 'dart:convert';

import 'package:flutter/services.dart';

import 'club_detail_service_interface.dart';

class ClubDetailMockService implements ClubDetailServiceInterface {
  static const _assetPath = 'assets/data/club_detail_page.json';

  @override
  Future<Map<String, dynamic>> fetchClubDetail() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
