import 'package:flutter/material.dart';

import '../service/localization/localization_service.dart';
import '../service/persistence/persistence_service.dart';
import '../util/locale/locale_config.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._persistenceService, this._localizationService)
      : _locale = LocaleConfig.resolve(
          _persistenceService.localeCode,
        );

  final PersistenceService _persistenceService;
  final LocalizationService _localizationService;

  Locale _locale;

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    _localizationService.updateLocale(locale.languageCode);
    await _persistenceService.setLocaleCode(locale.languageCode);
    notifyListeners();
  }
}
