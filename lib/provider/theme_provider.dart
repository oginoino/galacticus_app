import 'package:flutter/material.dart';

import '../service/persistence/persistence_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._persistenceService)
      : _themeMode = _themeModeFromStorage(_persistenceService.themeModeName);

  final PersistenceService _persistenceService;

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _persistenceService.setThemeModeName(_themeMode.name);
    notifyListeners();
  }

  static ThemeMode _themeModeFromStorage(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
  }
}
