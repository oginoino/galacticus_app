import 'dart:convert';

import 'package:flutter/services.dart';

import 'post_detail_service_interface.dart';

class PostDetailMockService implements PostDetailServiceInterface {
  static const _assetPath = 'assets/data/post_detail_page.json';

  @override
  Future<Map<String, dynamic>> fetchPostDetail() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final raw = await rootBundle.loadString(_assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
