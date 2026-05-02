import 'dart:convert';

import 'package:flutter/services.dart';

abstract class BaseRepository {
  Future<Map<String, dynamic>> loadJsonObject(String assetPath) async {
    final rawString = await rootBundle.loadString(assetPath);
    return jsonDecode(rawString) as Map<String, dynamic>;
  }

  String assetPath(String filename) => 'assets/data/$filename';

  Uri buildUri(
    String baseUrl,
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    final sanitizedParams = <String, dynamic>{
      for (final entry in (queryParameters ?? {}).entries)
        if (entry.value != null && '$entry.value'.isNotEmpty) entry.key: entry.value,
    };

    return Uri.parse(baseUrl).replace(
      path: path,
      queryParameters: sanitizedParams.isEmpty
          ? null
          : sanitizedParams.map(
              (key, value) => MapEntry(key, value.toString()),
            ),
    );
  }
}
