class LocalizationService {
  LocalizationService({
    required String initialLocaleCode,
  }) : _localeCode = initialLocaleCode;

  String _localeCode;

  String get localeCode => _localeCode;

  void updateLocale(String localeCode) {
    _localeCode = localeCode;
  }
}
