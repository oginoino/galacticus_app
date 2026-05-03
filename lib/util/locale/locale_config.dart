import 'package:flutter/material.dart';

abstract final class LocaleConfig {
  static const defaultLocale = Locale('pt');

  static const supportedLocales = [
    Locale('pt'),
    Locale('en'),
    Locale('es'),
  ];

  static Locale resolve(String? code) {
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == code,
      orElse: () => defaultLocale,
    );
  }
}
