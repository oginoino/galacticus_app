import 'environment/environment.dart';

class AppConstants {
  const AppConstants({
    required this.appName,
    required this.appVersion,
    required this.appTitle,
    required this.appDescription,
    required this.authBaseUrl,
    required this.coreApiBaseUrl,
  });

  final String appName;
  final String appVersion;
  final String appTitle;
  final String appDescription;
  final String authBaseUrl;
  final String coreApiBaseUrl;

  static const instance = AppConstants(
    appName: Environment.appName,
    appVersion: Environment.appVersion,
    appTitle: Environment.appTitle,
    appDescription: Environment.appDescription,
    authBaseUrl: Environment.authBaseUrl,
    coreApiBaseUrl: Environment.coreApiBaseUrl,
  );
}
