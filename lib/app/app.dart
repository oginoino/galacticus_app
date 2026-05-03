import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../di/di.dart';
import '../provider/locale_provider.dart';
import '../provider/theme_provider.dart';
import '../route/router/router.dart';
import '../ui/theme/app_theme.dart';
import '../util/const/app_constants.dart';
import '../util/locale/locale_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final appConstants = sl<AppConstants>();

    return MaterialApp.router(
      title: appConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      supportedLocales: LocaleConfig.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
    );
  }
}
