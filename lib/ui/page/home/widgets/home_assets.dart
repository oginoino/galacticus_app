import 'package:flutter/material.dart';

bool isCompactWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width <= 393;
}
