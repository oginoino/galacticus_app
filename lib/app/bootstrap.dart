import 'package:go_router/go_router.dart';

import '../di/di.dart';

class Bootstrap {
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    await DependencyInjection.register();
    GoRouter.optionURLReflectsImperativeAPIs = true;
    _isInitialized = true;
  }
}
