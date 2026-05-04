import 'dart:convert';

import 'package:flutter/services.dart';

import 'notifications_service_interface.dart';

class NotificationsMockService implements NotificationsServiceInterface {
  static const _assetPath = 'assets/data/notifications_page.json';

  @override
  Future<Map<String, dynamic>> fetchNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
