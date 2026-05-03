import 'dart:convert';

import 'package:flutter/services.dart';

import 'lessons_service_interface.dart';

class LessonsMockService implements LessonsServiceInterface {
  static const _assetPath = 'assets/data/lessons_page.json';

  @override
  Future<Map<String, dynamic>> fetchLessons() async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
