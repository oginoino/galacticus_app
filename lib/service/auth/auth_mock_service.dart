import 'dart:convert';

import 'package:flutter/services.dart';

import 'auth_service_interface.dart';

class AuthMockService implements AuthServiceInterface {
  static const _assetPath = 'assets/data/auth_overview.json';
  static const _loadDelay = Duration(milliseconds: 220);
  static const _submitDelay = Duration(milliseconds: 600);

  @override
  Future<Map<String, dynamic>> fetchOverview() async {
    await Future<void>.delayed(_loadDelay);
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  @override
  Future<void> submitLogin({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_submitDelay);
  }

  @override
  Future<void> submitRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_submitDelay);
  }

  @override
  Future<void> submitPasswordRecovery({required String email}) async {
    await Future<void>.delayed(_submitDelay);
  }
}
