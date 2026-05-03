import 'dart:convert';

import 'package:flutter/services.dart';

import 'profile_service_interface.dart';

class ProfileMockService implements ProfileServiceInterface {
  static const _assetPath = 'assets/data/profile_page.json';

  @override
  Future<Map<String, dynamic>> fetchProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
