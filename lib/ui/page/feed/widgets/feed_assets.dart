import 'package:flutter/material.dart';

bool isFeedCompactWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width <= 393;
}

Color colorFromHex(String hex) {
  final normalized = hex.replaceFirst('#', '');
  final withAlpha = normalized.length == 6 ? 'FF$normalized' : normalized;
  return Color(int.parse(withAlpha, radix: 16));
}
