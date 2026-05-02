import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'provider/register_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  await Bootstrap.init();

  runApp(
    MultiProvider(
      providers: registerProviders,
      child: const App(),
    ),
  );
}
