import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static const _themeModeKey = 'theme_mode';
  static const _localeCodeKey = 'locale_code';

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  String? get themeModeName => _preferences?.getString(_themeModeKey);

  String get localeCode => _preferences?.getString(_localeCodeKey) ?? 'pt';

  Future<void> setThemeModeName(String value) async {
    await _preferences?.setString(_themeModeKey, value);
  }

  Future<void> setLocaleCode(String value) async {
    await _preferences?.setString(_localeCodeKey, value);
  }
}
